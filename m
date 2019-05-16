Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF533C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80432082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfEPS6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:58:54 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:36872 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726547AbfEPS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:58:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CF456837F24D;
        Thu, 16 May 2019 18:58:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: face21_1325a5dd1fd49
X-Filterd-Recvd-Size: 3320
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 May 2019 18:58:51 +0000 (UTC)
Message-ID: <0145d042645da5c802e2f2bac46f847ad1e28587.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8723bs: core: rtw_recv: fix warning
 Comparison to NULL
From:   Joe Perches <joe@perches.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 May 2019 11:58:49 -0700
In-Reply-To: <20190516182538.GA4025@hari-Inspiron-1545>
References: <20190515174536.GA4965@hari-Inspiron-1545>
         <20190516080056.GH31203@kadam> <20190516182538.GA4025@hari-Inspiron-1545>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-16 at 23:55 +0530, Hariprasad Kelam wrote:
> On Thu, May 16, 2019 at 11:00:56AM +0300, Dan Carpenter wrote:
> > On Wed, May 15, 2019 at 11:15:36PM +0530, Hariprasad Kelam wrote:
> > > @@ -1042,7 +1042,7 @@ sint sta2ap_data_frame(
> > >  		}
> > >  
> > >  		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
> > > -		if (*psta == NULL) {
> > > +		if (!*psta == NULL) {
> >                     ^^^^^^^^^^^^^^
> > It's surprising that this didn't cause some kind of warning somewhere...
> 
> Thanks for pointing out this error. Here my intention is to write
>                 if(!*psta) 
> but somehow i missed it .
> 
> Will resend this patch after correcting the same.Like below
> 
> > -           if (*psta == NULL) {
> > > +           if (!*psta) {

You could run the coccinelle spatch file for bool
comparisons on the files instead.  It's much less
error prone.

$ spatch --sp-file scripts/coccinelle/misc/boolconv.cocci --in-place drivers/staging/rtl8723bs/

Or you could use a patch to checkpatch like below and then use

$ git ls-files drivers/staging/rtl8723bs | \
  xargs ./scripts/checkpatch.pl -f --fix-inplace --types=bool_comparison

but that definitely would not be as good as the coccinelle
tool use as coccinelle is much better at parsing expressions.

---
 scripts/checkpatch.pl | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1c421ac42b07..fe83aa0b1f97 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6407,11 +6407,13 @@ sub process {
 					$op = "";
 				}
 
-				CHK("BOOL_COMPARISON",
-				    "Using comparison to $otype is error prone\n" . $herecurr);
-
+				if (CHK("BOOL_COMPARISON",
+					"Using comparison to $otype is error prone\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\b(?:true|false|$Lval)\s*(?:==|\!=)\s*(?:true|false|$Lval)\b/${op}${arg}/;
+				}
 ## maybe suggesting a correct construct would better
-##				    "Using comparison to $otype is error prone.  Perhaps use '${lead}${op}${arg}${trail}'\n" . $herecurr);
+##					"Using comparison to $otype is error prone.  Perhaps use '${lead}${op}${arg}${trail}'\n" . $herecurr);
 
 			}
 		}


