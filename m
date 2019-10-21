Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E62CCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CF320873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfJUPpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:45:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37835 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:45:43 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <tyhicks@canonical.com>)
        id 1iMZsI-0001pK-3G; Mon, 21 Oct 2019 15:45:38 +0000
Date:   Mon, 21 Oct 2019 10:45:34 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     john.johansen@canonical.com, emamd001@umn.edu, smccaman@umn.edu,
        kjlu@umn.edu, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] apparmor: Fix use-after-free in aa_audit_rule_init
Message-ID: <20191021154533.GB12140@elm>
References: <57b61298-cbeb-f0ff-c6ba-b8f64d5d0287@canonical.com>
 <20191021152348.3906-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021152348.3906-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-21 10:23:47, Navid Emamdoost wrote:
> In the implementation of aa_audit_rule_init(), when aa_label_parse()
> fails the allocated memory for rule is released using
> aa_audit_rule_free(). But after this release, the return statement
> tries to access the label field of the rule which results in
> use-after-free. Before releasing the rule, copy errNo and return it
> after release.
> 
> Fixes: 52e8c38001d8 ("apparmor: Fix memory leak of rule on error exit path")

Ugh! I'm not sure what I was thinking when I authored that patch. :/

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> Changes in v2:
> 	-- Fix typo in description
> 	-- move err definition inside the if statement.
> 
>  security/apparmor/audit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
> index 5a98661a8b46..334065302fb6 100644
> --- a/security/apparmor/audit.c
> +++ b/security/apparmor/audit.c
> @@ -197,8 +197,9 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  	rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
>  				     GFP_KERNEL, true, false);
>  	if (IS_ERR(rule->label)) {
> +		int err = rule->label;

Since rule->label is a pointer, I'd like to see this:

 int err = PTR_ERR(rule->label);

>  		aa_audit_rule_free(rule);
> -		return PTR_ERR(rule->label);
> +		return PTR_ERR(err);

This line would change to:

 return err;


Tyler

>  	}
>  
>  	*vrule = rule;
> -- 
> 2.17.1
> 
