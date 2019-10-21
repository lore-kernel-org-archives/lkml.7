Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A66CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8A4214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfJUQIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:08:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38911 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbfJUQIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:08:22 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <tyhicks@canonical.com>)
        id 1iMaEF-0000sX-Ga; Mon, 21 Oct 2019 16:08:19 +0000
Date:   Mon, 21 Oct 2019 11:08:14 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] apparmor: Fix use-after-free in aa_audit_rule_init
Message-ID: <20191021160814.GC12140@elm>
References: <20191021154533.GB12140@elm>
 <20191021160532.7719-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021160532.7719-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-21 11:05:31, Navid Emamdoost wrote:
> In the implementation of aa_audit_rule_init(), when aa_label_parse()
> fails the allocated memory for rule is released using
> aa_audit_rule_free(). But after this release, the return statement
> tries to access the label field of the rule which results in
> use-after-free. Before releasing the rule, copy errNo and return it
> after release.
> 
> Fixes: 52e8c38001d8 ("apparmor: Fix memory leak of rule on error exit path")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Reviewed-by: Tyler Hicks <tyhicks@canonical.com>

Thanks!

Tyler

> ---
> Changes in v3:
> 	-- applied Tyler Hicks recommendation on err initialization.
> 
>  security/apparmor/audit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
> index 5a98661a8b46..597732503815 100644
> --- a/security/apparmor/audit.c
> +++ b/security/apparmor/audit.c
> @@ -197,8 +197,9 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  	rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
>  				     GFP_KERNEL, true, false);
>  	if (IS_ERR(rule->label)) {
> +		int err = PTR_ERR(rule->label);
>  		aa_audit_rule_free(rule);
> -		return PTR_ERR(rule->label);
> +		return err;
>  	}
>  
>  	*vrule = rule;
> -- 
> 2.17.1
> 
