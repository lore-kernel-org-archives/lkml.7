Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A97C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237F5206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbfHARv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:51:26 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:40995 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727899AbfHARvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:51:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A41C018029123;
        Thu,  1 Aug 2019 17:51:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: club18_80939144a8607
X-Filterd-Recvd-Size: 3545
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 17:51:23 +0000 (UTC)
Message-ID: <aab16d5347eb5378c8b8a24571a070dbf8926010.camel@perches.com>
Subject: Re: [PATCH 08/12] printk: Replace strncmp with str_has_prefix
From:   Joe Perches <joe@perches.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 10:51:22 -0700
In-Reply-To: <CANhBUQ2RD065Dn8eGkbzSQxfie5XrR_kgaFQ1QgOS4cKNhAfPA@mail.gmail.com>
References: <20190729151505.9660-1-hslester96@gmail.com>
         <5dee05d6cb8498b3e636f5e8a62da673334cb5a9.camel@perches.com>
         <CANhBUQ2RD065Dn8eGkbzSQxfie5XrR_kgaFQ1QgOS4cKNhAfPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 23:23 +0800, Chuhong Yuan wrote:
> Joe Perches <joe@perches.com> 于2019年7月30日周二 上午8:16写道：
> > On Mon, 2019-07-29 at 23:15 +0800, Chuhong Yuan wrote:
> > > strncmp(str, const, len) is error-prone.
> > > We had better use newly introduced
> > > str_has_prefix() instead of it.
> > []
> > > diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
> > []
> > > @@ -11,10 +11,10 @@
> > > 
> > >  int _braille_console_setup(char **str, char **brl_options)
> > >  {
> > > -     if (!strncmp(*str, "brl,", 4)) {
> > > +     if (str_has_prefix(*str, "brl,")) {
> > >               *brl_options = "";
> > >               *str += 4;
> > > -     } else if (!strncmp(*str, "brl=", 4)) {
> > > +     } else if (str_has_prefix(*str, "brl=")) {
> > >               *brl_options = *str + 4;
> > 
> > Better to get rid of the += 4 uses too by storing the result
> > of str_has_prefix and using that as the addend.
> > 
> > Perhaps
> >         size_t len;
> > 
> >         if ((len = str_has_prefix(*str, "brl,"))) {
> >                 *brl_options = "";
> >                 *str += len;
> >         } else if ((len = str_has_prefix(*str, "brl="))) {
> >                 etc...
> > 
> 
> I find that checkpatch.pl forbids assignment in if condition.
> So this seems to be infeasible...

So the code could be rewritten like below:
(though it's trivial as-is)
---
 kernel/printk/braille.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
index 1d21ebacfdb8..46dd9fcc7525 100644
--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -11,19 +11,29 @@
 
 int _braille_console_setup(char **str, char **brl_options)
 {
-	if (!strncmp(*str, "brl,", 4)) {
+	size_t len;
+
+	len = str_has_prefix(*str, "brl,");
+	if (len) {
 		*brl_options = "";
-		*str += 4;
-	} else if (!strncmp(*str, "brl=", 4)) {
-		*brl_options = *str + 4;
-		*str = strchr(*brl_options, ',');
-		if (!*str) {
-			pr_err("need port name after brl=\n");
-			return -EINVAL;
-		}
-		*((*str)++) = 0;
+		*str += len;
+		return 0;
+	}
+
+	len = str_has_prefix(*str, "brl=");
+	if (!len)
+		return 0;
+
+	*brl_options = *str + len;
+
+	*str = strchr(*brl_options, ',');
+	if (!*str) {
+		pr_err("need port name after brl=\n");
+		return -EINVAL;
 	}
 
+	*((*str)++) = 0;
+
 	return 0;
 }
 

