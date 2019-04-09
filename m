Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64550C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E77320850
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cyXI0zXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfDIXa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:30:56 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:40638 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbfDIXaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554852653; bh=r6OM4e+8zTaJGMV5oIvNgHYtpSkgbss9dPmlcPviyGA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=cyXI0zXfSLuJjijBFsEZkvC6UPyUt/xfXsnT6FBIhMyy+ekY/Af4LBUSp343Iv8nKP9gmZuEFRakmbKqsIW0Ro4CeVM8kFevgGGcHTwUC09gcbBImOmVI3IkIgxpM6N+zvTHXBhyri173IVBVo/V7nxCJKiZ6ezSDonlmIF+apvH/ypjPhxXWU2sIAUjjgVFbJwxbkFGTY+zSPIJdzQ/2MpVbaxOtVF3YnhHFi6Nol9ejAQ113Mj+R/bIdcIfpnlqqVoOs7ObAWSN2RRMCZZ/Dlob3LAhstj7xh8KOder+54DuWnZyPMe2JbYpt+fsQjNY83svn5D5PKRgOod+XWLA==
X-YMail-OSG: OUTNC4oVM1nYJNWQKA5QcJ3mFpUZ52uicGXZ6QCUhQlfaBiwNzoGBgR7jKnQ23E
 lExDGfnngdtPbyLjuGaiVTRTQnnifFmxwgi3_APuM9RHdhVkGMTN6ilLJhE2LXjKzil_vLuCeQjj
 Ud3eSdnglwfv99wMcAfjgvu7m3d5pEo5IOzHVz3Jtvkp4GHuEsXplugaOtlOaHcNscKwkUkoP5gK
 LfmeZh8LLTzZsHfB..W7aghshQddTvG3loPDp6T1xynV2J927f6K7xnrs5_aCl2MZMhIHTIXVPjC
 qRMMUr1exl2.6PLFRevWKevJDcS8bygi1mpEJWvXxCACuJsVpgCKFExDJblWBcPc_HzaXeMqA3Rm
 8tSsfupVveS8G69kAdPhf8ESZETyULHD.eGOnT8HNB9s6g4fnDn.YR_vzFZ3W2NCoxBVPuNb9fnI
 tqs40tZiJcmDcj5IQlYuai_J548CwVU17mSpzk9mukxq7Rc82S.uyfjxULyPgcxmlPB516b5UfA.
 sLdWtyB7kDjSuFWixsIgVu2vZMFbr.Gm9m1Rm5dDBQl9VU9tZEY40i1QcYP8F5GIYMnK14f2qWz9
 K2KpyBEnvFC8V7LNiNUIsgtda._.4kdgO6PS8IcMTHpmHN0lkdvT6noGh.NiH6avOyPHYMVJzVNu
 OQVmCC7aYKr5EgHaTqyq_9rUSwvaSgSk18cp2QA3cZ6qyAuRuyqW_f.813PiNREtrDYRtnoJdU8n
 GUQlbW.0yKN6.wxp7cWAPj7CbsZFEF8NUWwFPZ1d27p0M03HKC0egdC3z4zwwK.wr8W5i1LKrdcz
 cXivnRamaeXArgTEEzVA0YythTT_pATScQpnzoFyIeDqygkcAIBbaA_Sj._T32gq6kYFVD4rXT8R
 Tp3eR4Egr5fDn_jJQaO_Q1fz0il0i9TlJuRnC7YUo9TM9aZmXIlEE6HFt9KiMfFAne_Nm_ZnY7bA
 1L2hLIUqscZkG5oO7eN_I2Hvhe9A4wJN1TdssK8xr3vvHHOm1HJLWcslA.tFoRbNSrOy9snWhHCx
 QVpXP2vDK5hG80NgPtJbsF5AxlGaMTueQWKHPLNqhI2GgTb3crlV.Jzzdt4a5aNENQIi1i8av9w2
 wcwELNgqNiqBYRVFxYS8zRsPEdepJbcZIeC0FgMRM3q2DYmeuGK4fst5eCrEzTJpQpQInLw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Tue, 9 Apr 2019 23:30:53 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dfd426c89d12d282fb8b590a8b6da0c0;
          Tue, 09 Apr 2019 23:30:49 +0000 (UTC)
Subject: Re: [PATCH 1/1] Smack: Create smack_rule cache to optimize memory
 usage
To:     Vishal Goel <vishal.goel@samsung.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     pankaj.m@samsung.com, a.sahrawat@samsung.com
References: <CGME20190314091717epcas5p34ec02dc48347e76c2ba7a9d9c6fa9abe@epcas5p3.samsung.com>
 <1552554393-11691-1-git-send-email-vishal.goel@samsung.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <fdd65731-493b-21e2-3325-073ba906cfb4@schaufler-ca.com>
Date:   Tue, 9 Apr 2019 16:30:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1552554393-11691-1-git-send-email-vishal.goel@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/2019 2:06 AM, Vishal Goel wrote:
> This patch allows for small memory optimization by creating the
> kmem cache for "struct smack_rule" instead of using kzalloc.
> For adding new smack rule, kzalloc is used to allocate the memory
> for "struct smack_rule". kzalloc will always allocate 32 or 64 bytes
> for 1 structure depending upon the kzalloc cache sizes available in
> system. Although the size of structure is 20 bytes only, resulting
> in memory wastage per object in the default pool.
>
> For e.g., if there are 20000 rules, then it will save 240KB(20000*12)
> which is crucial for small memory targets.
>
> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
> Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>

I have taken this patch in for
	https://github.com/cschaufler/next-smack.git#smack-for-5.2

> ---
>   security/smack/smack.h     |  1 +
>   security/smack/smack_lsm.c | 12 ++++++++++--
>   security/smack/smackfs.c   |  2 +-
>   3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 6a71fc7..a5d7461 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -354,6 +354,7 @@ int smk_tskacc(struct task_smack *, struct smack_known *,
>   
>   #define SMACK_HASH_SLOTS 16
>   extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
> +extern struct kmem_cache *smack_rule_cache;
>   
>   /*
>    * Is the directory transmuting?
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 319add3..16b6cf5 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -56,6 +56,7 @@
>   static LIST_HEAD(smk_ipv6_port_list);
>   #endif
>   static struct kmem_cache *smack_inode_cache;
> +struct kmem_cache *smack_rule_cache;
>   int smack_enabled;
>   
>   static const match_table_t smk_mount_tokens = {
> @@ -349,7 +350,7 @@ static int smk_copy_rules(struct list_head *nhead, struct list_head *ohead,
>   	int rc = 0;
>   
>   	list_for_each_entry_rcu(orp, ohead, list) {
> -		nrp = kzalloc(sizeof(struct smack_rule), gfp);
> +		nrp = kmem_cache_zalloc(smack_rule_cache, gfp);
>   		if (nrp == NULL) {
>   			rc = -ENOMEM;
>   			break;
> @@ -1995,7 +1996,7 @@ static void smack_cred_free(struct cred *cred)
>   	list_for_each_safe(l, n, &tsp->smk_rules) {
>   		rp = list_entry(l, struct smack_rule, list);
>   		list_del(&rp->list);
> -		kfree(rp);
> +		kmem_cache_free(smack_rule_cache, rp);
>   	}
>   	kfree(tsp);
>   }
> @@ -4788,10 +4789,17 @@ static __init int smack_init(void)
>   	if (!smack_inode_cache)
>   		return -ENOMEM;
>   
> +	smack_rule_cache = KMEM_CACHE(smack_rule, 0);
> +	if (!smack_rule_cache) {
> +		kmem_cache_destroy(smack_inode_cache);
> +		return -ENOMEM;
> +	}
> +
>   	tsp = new_task_smack(&smack_known_floor, &smack_known_floor,
>   				GFP_KERNEL);
>   	if (tsp == NULL) {
>   		kmem_cache_destroy(smack_inode_cache);
> +		kmem_cache_destroy(smack_rule_cache);
>   		return -ENOMEM;
>   	}
>   
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 2a8a1f5..d8a0e25 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -236,7 +236,7 @@ static int smk_set_access(struct smack_parsed_rule *srp,
>   	}
>   
>   	if (found == 0) {
> -		sp = kzalloc(sizeof(*sp), GFP_KERNEL);
> +		sp = kmem_cache_zalloc(smack_rule_cache, GFP_KERNEL);
>   		if (sp == NULL) {
>   			rc = -ENOMEM;
>   			goto out;
