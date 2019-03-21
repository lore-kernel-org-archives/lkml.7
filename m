Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631DEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1AE21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfCUWre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:47:34 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:51090 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725999AbfCUWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:47:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 51BB818224D82;
        Thu, 21 Mar 2019 22:47:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: alarm81_414a022265a5b
X-Filterd-Recvd-Size: 2733
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 Mar 2019 22:47:28 +0000 (UTC)
Message-ID: <0cc879a63943b57b62caddce6866b83a14b42c14.camel@perches.com>
Subject: Re: [PATCH v2] docs: Clarify the usage and sign-off requirements
 for Co-developed-by
From:   Joe Perches <joe@perches.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Date:   Thu, 21 Mar 2019 15:47:26 -0700
In-Reply-To: <20190321192341.GG6519@linux.intel.com>
References: <20190321184316.8525-1-sean.j.christopherson@intel.com>
         <20190321192341.GG6519@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-21 at 12:23 -0700, Sean Christopherson wrote:
> On Thu, Mar 21, 2019 at 11:43:16AM -0700, Sean Christopherson wrote:
> > The documentation for Co-developed-by is a bit light on details, e.g. it
> > doesn't explicitly state that:
> > 
> >   - Multiple Co-developed-by tags are perfectly acceptable
> >   - Co-developed-by and Signed-off-by must be paired together
> >   - SOB ordering should still follow standard sign-off procedure

While I still think co-developed-by: is unnecessary and
almost none of the existing uses of this have this
sequence of "Co-developed-by: <name/email>" followed directly
by "Signed-off-by: <same name/email>", here's a possible
checkpatch addition for it.

---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d0001fd1112d..e938fd56cc20 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2687,6 +2687,15 @@ sub process {
 			} else {
 				$signatures{$sig_nospace} = 1;
 			}
+
+# Check Co-developed-by: suceeded by Signed-off-by: with same name and email
+			if ($sign_off =~ /^signed-off-by:$/i &&
+			    $linenr > 1 &&
+			    $rawlines[$linenr - 2] =~ /^\s*co-developed-by:\s*(.*)/i &&
+			    $1 ne $email) {
+				WARN("BAD_SIGN_OFF",
+				     "Co-developed-by: should be suceeded by Signed-off-by: with same name/email\n" . "$here\n" . $rawlines[$linenr - 2] . "\n" . $rawline);
+			}
 		}
 
 # Check email subject for common tools that don't need to be mentioned

