Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D93C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887BA206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfDYSVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbfDYSVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:21:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13085E951D;
        Thu, 25 Apr 2019 18:21:36 +0000 (UTC)
Received: from laptop.jcline.org (unknown [10.13.105.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE3B260C9A;
        Thu, 25 Apr 2019 18:21:35 +0000 (UTC)
Received: from laptop.jcline.org (localhost [IPv6:::1])
        by laptop.jcline.org (Postfix) with ESMTPS id 480DF45E552C;
        Thu, 25 Apr 2019 14:21:35 -0400 (EDT)
Date:   Thu, 25 Apr 2019 14:21:34 -0400
From:   Jeremy Cline <jcline@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Robert Holmes <robeholmes@gmail.com>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, stable@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH v2] KEYS: Make use of platform keyring for module
 signature verify
Message-ID: <20190425182134.GA7823@laptop.jcline.org>
References: <1556116431-7129-1-git-send-email-robeholmes@gmail.com>
 <1556193350.3894.92.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556193350.3894.92.camel@linux.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 25 Apr 2019 18:21:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 25, 2019 at 07:55:50AM -0400, Mimi Zohar wrote:
> On Wed, 2019-04-24 at 14:33 +0000, Robert Holmes wrote:
> > This patch completes commit 278311e417be ("kexec, KEYS: Make use of
> > platform keyring for signature verify") which, while adding the
> > platform keyring for bzImage verification, neglected to also add
> > this keyring for module verification.
> > 
> > As such, kernel modules signed with keys from the MokList variable
> > were not successfully verified.
> 
> Using the platform keyring keys for verifying kernel modules was not
> neglected, but rather intentional.  This patch description should
> clearly explain the reason for needing to verify kernel module
> signatures based on the pre-boot keys.  (Hint: verifying kernel
> modules based on the pre-boot keys was previously rejected.)

So the background for this patch is that Fedora, which carries the
lockdown patch set, recently regressed[0] with respect to user-signed
modules. Previously, we carried a patch that added all the pre-boot keys
to the secondary keyring. That way users could add a machine owner key
and use secure boot and lockdown with their self-signed 3rd party modules.

Since the pre-boot keys are now loaded into the platform keyring, I
suggested that Robert submit the patch upstream, but since the lockdown
patches aren't upstream perhaps it doesn't make much sense to pick this
up and Fedora should continue carrying it.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1701096

Regards,
Jeremy

> > 
> > Signed-off-by: Robert Holmes <robeholmes@gmail.com>
> > Cc: linux-integrity@vger.kernel.org
> > Cc: keyrings@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > ---
> >  kernel/module_signing.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> > index 6b9a926fd86b..cf94220e9154 100644
> > --- a/kernel/module_signing.c
> > +++ b/kernel/module_signing.c
> > @@ -49,6 +49,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
> >  {
> >  	struct module_signature ms;
> >  	size_t sig_len, modlen = info->len;
> > +	int ret;
> > 
> >  	pr_devel("==>%s(,%zu)\n", __func__, modlen);
> > 
> > @@ -82,8 +83,15 @@ int mod_verify_sig(const void *mod, struct load_info *info)
> >  		return -EBADMSG;
> >  	}
> > 
> > -	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> > -				      VERIFY_USE_SECONDARY_KEYRING,
> > -				      VERIFYING_MODULE_SIGNATURE,
> > -				      NULL, NULL);
> > +	ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> > +				     VERIFY_USE_SECONDARY_KEYRING,
> > +				     VERIFYING_MODULE_SIGNATURE,
> > +				     NULL, NULL);
> > +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> > +		ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> > +					     VERIFY_USE_PLATFORM_KEYRING,
> > +					     VERIFYING_MODULE_SIGNATURE,
> > +					     NULL, NULL);
> > +	}
> > +	return ret;
> >  }
> 
