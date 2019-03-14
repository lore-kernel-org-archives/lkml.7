Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F94C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F4821855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Y4nokHiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCNRHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:07:30 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:43461
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfCNRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1552583248; bh=gn5t6vu2hvyR95IDwhBAKbSpqU3W0aNTz6G4Uiw0zmI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Y4nokHiUbYSRuUyckYWhS0F9azsiCQzepd0znOFRlCjSe3lfkDZnINNLPrmtkVHEEAw0q8v+UtS53EGzkMK3dYLl1wY5EAdaXuh0H5se2k3v4WQ7kwccFxxvo/AMs67QMbldoyTJkYa7LKY8Jzba55gkgUC6NFxdgQbd2EQO7jMhmCD+yy0RbBkzXwsU8rsO+AxLx/X87tIjBE1F28qJ1MM5htD38H7usf9JNT7VEQLF+yWr4OJgAFAB4LbmZZQdBWKM/cPC5/EOxZLlQcXMzMHRufZk8bBo76ykDvac5fDGWrUBH41GyxUroXT7eIAtg4TmbUrZu2U1Jk9sHiQz1g==
X-YMail-OSG: fAvsVJkVM1npapHwmMluQ4b6m6h4XLlrPJxRHiRmI3oJ7Kn6My8VZ4TMCwcekEq
 Pn8zUvgp1pWVwnMmizd2WFujsEzZ2tVlmnkRKnU6FV7BLXO1k11KOaNeje9ftl487wi.SkNwcwjF
 RiwI_S.3PIpKZ_cWR.ms8q4w0ReaY_RFzYXYwdVQYl4F1oWS605KT74CI0Jul7D0BKG48l585kp2
 vD0hOl9a8egP2ultC_1zBfHyl8Sicu2VzbfpJx0xzHw0DoZ7ZDqX7JWfEC0HHa2Jk0eWIw9pU476
 2j3cha2HWAqizbcV.R_vioo_8r5CPBsjDGqB3Ap3MCs9wIRhAWwPi2aCQcDKKgaJnAa4gP3ryv8H
 5JkAoxxsAPuwskrZ49X.5UoxRCcKZi3Xk01UqCwKrb_AuxjoYJSwWK1rUr_TtSHCQR0bbKfdeww6
 _TuHhep.iAQDCO6ruSlRSzClyxCEcIOb3ifdpwwwcny8CzG3VMt5mtEYS963NsFkC8HQT0_iUUZm
 4_FgSQCj593BtRMbkNylFy7fPwhcpHP8Pp.4OiKORZgURlmxkD.t3habFBHsyHH01W1jsetl_Hf7
 1ZepwDikDfQ5fDCGzNzuUVs.DGTa9eoe4HChLrH.I8VKj.6Q0g0WtoeLJZWbPxF_jx1rdj5TmNFp
 1EeX0a1yyBceEBa4W8EXZMX3aNeVqljdiitH2CgIl1xDIF0Cc7.JEi2PqwkJKMtatZkVtCXME1Xs
 ZDpHmVviZ0mx33zAKsm.u5z8M0j1wIs23pneKnuN13CkdVd_AVdgLEgDtnN9RccOSfKlaEga.xLd
 vZUgjQAQLzNjdDihhlTypanUxx3DLUwFzdtSpcrwOR62RQov7Ze835ertxOWnvqAvUP0W16dHw5I
 9Vr4iCicdy.kcu_OiJhqE0eb29iN6OWpeoLwTkjfQh3eOrn4XukL1sD518q6Wa51CZHPEHpT8Brs
 iAbC62lQhoYN8LVxTJJDeqEVDrFQyc0lEoSJMmWWkBPzqjSmGOtc5GHzuk8vbEKI1yOPg9W6BcwW
 V_5FVraNvhYbOvifOfoq6vn9FVh6T5cV6Op_vG_U1qEb_rbtsIUi0TUoWskUd_7zYM9dC8u6R4aL
 Bz2Bob5ynQkvVdzvVxlM9nmL.VgMnRwsURic7qhPB7Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 Mar 2019 17:07:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7a37b4fdb9545bb6d9db61bbde8f2268;
          Thu, 14 Mar 2019 17:07:26 +0000 (UTC)
Subject: Re: [PATCH 1/1] Smack: Create smack_rule cache to optimize memory
 usage
To:     Vishal Goel <vishal.goel@samsung.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     pankaj.m@samsung.com, a.sahrawat@samsung.com,
        casey@schaufler-ca.com
References: <CGME20190314091717epcas5p34ec02dc48347e76c2ba7a9d9c6fa9abe@epcas5p3.samsung.com>
 <1552554393-11691-1-git-send-email-vishal.goel@samsung.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8ff11918-d4c6-580f-e9ad-3d92d4f71016@schaufler-ca.com>
Date:   Thu, 14 Mar 2019 10:07:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
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

I will take this for 5.2.
Thank you. Keep up the good work.

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
