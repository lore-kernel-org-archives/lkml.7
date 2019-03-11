Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81650C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BA82087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfCKW6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:58:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65439 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfCKW6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:58:14 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id bc8426080770e0a5; Mon, 11 Mar 2019 23:58:11 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ACPI / sysfs: Restructure get_status
Date:   Mon, 11 Mar 2019 23:56:27 +0100
Message-ID: <3133462.vhohJv2aGS@aspire.rjw.lan>
In-Reply-To: <1766077.IDCbULq7Lr@aspire.rjw.lan>
References: <20190307173802.3448-1-natechancellor@gmail.com> <1766077.IDCbULq7Lr@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 11, 2019 11:46:14 PM CET Rafael J. Wysocki wrote:
> On Thursday, March 7, 2019 6:38:02 PM CET Nathan Chancellor wrote:
> > When building with -Wsometimes-uninitialized, Clang warns:
> > 
> > drivers/acpi/sysfs.c:667:13: warning: variable 'result' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> > 
> > Clang can't determine that all cases are covered by the two separate if
> > statements. We could combine then to look like this:
> > 
> >     int result;
> > 
> >     if (...) {
> >         ...
> >     } else if {
> >         ...
> >     } else {
> >         result -EINVAL;
> >     }
> > 
> >     return result;
> > 
> > However, at that point, we can further simplify this function by only
> > using result when absolutely needed and just direct returning the value
> > of the function.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/388
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/acpi/sysfs.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> > index 41324f0b1bee..6ed785cadad9 100644
> > --- a/drivers/acpi/sysfs.c
> > +++ b/drivers/acpi/sysfs.c
> > @@ -651,23 +651,18 @@ static void acpi_global_event_handler(u32 event_type, acpi_handle device,
> >  static int get_status(u32 index, acpi_event_status *status,
> >  		      acpi_handle *handle)
> >  {
> > -	int result;
> > -
> > -	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
> > -		return -EINVAL;
> > -
> >  	if (index < num_gpes) {
> > -		result = acpi_get_gpe_device(index, handle);
> > +		int result = acpi_get_gpe_device(index, handle);
> >  		if (result) {
> >  			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
> >  					"Invalid GPE 0x%x", index));
> >  			return result;
> >  		}
> > -		result = acpi_get_gpe_status(*handle, index, status);
> > +		return acpi_get_gpe_status(*handle, index, status);
> >  	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
> 
> In principle, it would suffice to replace the "else if (...)" with "else"
> to fix the Clang warning AFAICS, but that's not the only issue with this
> function.
> 
> > -		result = acpi_get_event_status(index - num_gpes, status);
> > +		return acpi_get_event_status(index - num_gpes, status);
> >  
> > -	return result;
> > +	return -EINVAL;
> >  }
> >  
> >  static ssize_t counter_show(struct kobject *kobj,
> 
> Namely, it confuses errno with acpi_status and may cause the latter to be
> returned to user space in certain situations which should never be done.
> 
> So, I'd prefer to apply something like the (untested so far) patch below.

Actually, acpi_get_event_status() returns acpi_status too, so something like
this rather:

---
 drivers/acpi/sysfs.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -648,26 +648,29 @@ static void acpi_global_event_handler(u3
 	}
 }
 
-static int get_status(u32 index, acpi_event_status *status,
+static int get_status(u32 index, acpi_event_status *ret,
 		      acpi_handle *handle)
 {
-	int result;
+	acpi_status status;
 
 	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
 		return -EINVAL;
 
 	if (index < num_gpes) {
-		result = acpi_get_gpe_device(index, handle);
-		if (result) {
+		status = acpi_get_gpe_device(index, handle);
+		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
 					"Invalid GPE 0x%x", index));
-			return result;
+			return -ENXIO;
 		}
-		result = acpi_get_gpe_status(*handle, index, status);
-	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
-		result = acpi_get_event_status(index - num_gpes, status);
+		status = acpi_get_gpe_status(*handle, index, ret);
+	} else {
+		status = acpi_get_event_status(index - num_gpes, ret);
+	}
+	if (ACPI_FAILURE(status))
+		return -EIO;
 
-	return result;
+	return 0;
 }
 
 static ssize_t counter_show(struct kobject *kobj,

