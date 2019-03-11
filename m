Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB371C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8D92147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="h5XGKmiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfCKVFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:05:17 -0400
Received: from sonic304-31.consmr.mail.gq1.yahoo.com ([98.137.68.212]:40373
        "EHLO sonic304-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727153AbfCKVFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1552338314; bh=YG+N7i+2f9AGSJLNQLcyJg2vbu4+f4kWeq2Y6kMoxSU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=h5XGKmiY/EptZaPM7rQlzU7i7ZuILrxrO9/djBaPDDXLbImg2aqjXYoPF9gyAOMXoY98XYKDWTCSo2GZCar7Uu9x5ztlhIZsk++OLdSouT5EvmET6SoBR+I1dRVHO1z8exlTBs+6mZY82Vj4cOKdLY6J9cPj8Y7kphbs2I1sIGltTv3Nhd5SDJkh7aAQITe7hJ1/FpivFRbrA6LlHCe/dzUJv2tWclNjNQ8hiWc/1jCUPxmr/3/bmq11olfXF49johg013uSm/jUNc8BIhSzFzyoOi11MItovYEkWLenPQozvOhpJkLBVK8XzrGBmeZOmSR6VUYjfpzjYzrA7m1mPw==
X-YMail-OSG: 5fi4ujYVM1k3hCLC_sBGEBPkOFrej5Jkq1xITgLWe5RCBGxlG3N.G4tL323b34y
 KLA4r_D8xXGmWrYmNAkC2QCN4rIzgZEx4rdKbRMuQqwaHF_XhAnSDYvdPfj.nVr7cTgb.a_5LzLf
 ekhpyna6QOTNv_F1.wS0P4O5R_alZulSIzlhVStVG1BL0Y_97o4adZbksqS_LQHzdS_R_2xc.a8g
 cbO_AQqsJ9Xult8Sv1QqR5LYYHttE1oxwoKM6BrDYA5DdilDLNRzBKWPVMAkT_iPw0aK0_0N3ehy
 jiQzevxDjCus1i3VOS4om.p5GY4OuBiprJSohOOZrE8WKL4XFgW0jXVlUweulaUo0o8BfVWo2ls6
 LQjoro_BfR0UgC9nGMoi65wGrcxAEj.X4UDKg5iGgYLOpo5MlTh.kmfB6_wi6ObENVF2CV5iitYN
 HtlBgahxpF52sKOYf.qX.sUCF2RKIxiyP7OlhKntJZMjUIC3CkzQJDD1z4SIihgg5APEu1mckE1v
 aEcUxo1VyGqJRbK5MB5KKmjAeyB.XOvXAuhGTZToA00H7nNp6YyrpIg.1HsYhSSqK33cH4dBHgct
 0p89BFbrBgFsZSQpraA8k2c7gbon4nKpUyZVbnSJH6CdTREhyMu0tn.Aous8mV9yKT04NjyECd3S
 dL0oXbX2oDlMKeVxe.TSqTS4Ovc_a.qI86IICRg6igDJ6R71TwEO5Y8QTpfgV9eyGes0Jmrk_SF9
 6z27QuwoPGNIpYNhzBGyHfyeviiRChZxTVu_SS2uXMIlZ.VFPm1QhN.i1bdmpOnbXXGtVhLFenB4
 tgR6QA3YesIKaEn6EGcyWZpVe09LIEn2GUtmj5AG6mr5UB_SndY3bQvJq2jnbLFry2U7dcf7ZXok
 EYSzooSwQmuPsWHYpi13.BfXcN5xwUCK08SXVk0pICg9PIncb2p57wqQacLypP6EcN.Y5dJ_hxiy
 2LEMWujEngBUuDeCVFDG0kH8B3B0KIS6C8fxWtFt46wPt1jtKY4_3sIsEoTkOsn3P9WFiYbBi35h
 ISJ8KyCre.eCXKMKoqZsdnDOQADyVRjUHtnVFSJHqQ_yf4AqAkKIWsZtUXEsXpahR.nQ64WRUle3
 cdUD.HYgfNVIJ_Rc3L.t31nkC7AK0bTYZ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Mon, 11 Mar 2019 21:05:14 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp428.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 438b4227f6f802dbd7b5dc40ca52de93;
          Mon, 11 Mar 2019 21:05:13 +0000 (UTC)
Subject: Re: [PATCH 1/1] smack: removal of global rule list
To:     Vishal Goel <vishal.goel@samsung.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     pankaj.m@samsung.com, a.sahrawat@samsung.com
References: <CGME20190307113608epcas5p1be102a5a4592055ab3c97df8a8339d98@epcas5p1.samsung.com>
 <1551957924-25113-1-git-send-email-vishal.goel@samsung.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <75cbfaa1-ddfe-7f95-5b69-6e0c000668ec@schaufler-ca.com>
Date:   Mon, 11 Mar 2019 14:05:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1551957924-25113-1-git-send-email-vishal.goel@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2019 3:25 AM, Vishal Goel wrote:
> In this patch, global rule list has been removed. Now all
> smack rules will be read using "smack_known_list". This list contains
> all the smack labels and internally each smack label structure
> maintains the list of smack rules corresponding to that smack label.
> So there is no need to maintain extra list.
>
> 1) Small Memory Optimization
> For eg. if there are 20000 rules, then it will save 625KB(20000*32),
> which is critical for small embedded systems.
> 2) Reducing the time taken in writing rules on load/load2 interface
> 3) Since global rule list is just used to read the rules, so there
> will be no performance impact on system
>
> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
> Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>

Looks fine. I will take it for 5.2.

> ---
>   security/smack/smackfs.c | 53 ++++++++++++++----------------------------------
>   1 file changed, 15 insertions(+), 38 deletions(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index f6482e5..2a8a1f5 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -67,7 +67,6 @@ enum smk_inos {
>   /*
>    * List locks
>    */
> -static DEFINE_MUTEX(smack_master_list_lock);
>   static DEFINE_MUTEX(smack_cipso_lock);
>   static DEFINE_MUTEX(smack_ambient_lock);
>   static DEFINE_MUTEX(smk_net4addr_lock);
> @@ -134,15 +133,7 @@ enum smk_inos {
>   
>   /*
>    * Rule lists are maintained for each label.
> - * This master list is just for reading /smack/load and /smack/load2.
>    */
> -struct smack_master_list {
> -	struct list_head	list;
> -	struct smack_rule	*smk_rule;
> -};
> -
> -static LIST_HEAD(smack_rule_list);
> -
>   struct smack_parsed_rule {
>   	struct smack_known	*smk_subject;
>   	struct smack_known	*smk_object;
> @@ -211,7 +202,6 @@ static void smk_netlabel_audit_set(struct netlbl_audit *nap)
>    * @srp: the rule to add or replace
>    * @rule_list: the list of rules
>    * @rule_lock: the rule list lock
> - * @global: if non-zero, indicates a global rule
>    *
>    * Looks through the current subject/object/access list for
>    * the subject/object pair and replaces the access that was
> @@ -223,10 +213,9 @@ static void smk_netlabel_audit_set(struct netlbl_audit *nap)
>    */
>   static int smk_set_access(struct smack_parsed_rule *srp,
>   				struct list_head *rule_list,
> -				struct mutex *rule_lock, int global)
> +				struct mutex *rule_lock)
>   {
>   	struct smack_rule *sp;
> -	struct smack_master_list *smlp;
>   	int found = 0;
>   	int rc = 0;
>   
> @@ -258,22 +247,6 @@ static int smk_set_access(struct smack_parsed_rule *srp,
>   		sp->smk_access = srp->smk_access1 & ~srp->smk_access2;
>   
>   		list_add_rcu(&sp->list, rule_list);
> -		/*
> -		 * If this is a global as opposed to self and a new rule
> -		 * it needs to get added for reporting.
> -		 */
> -		if (global) {
> -			mutex_unlock(rule_lock);
> -			smlp = kzalloc(sizeof(*smlp), GFP_KERNEL);
> -			if (smlp != NULL) {
> -				smlp->smk_rule = sp;
> -				mutex_lock(&smack_master_list_lock);
> -				list_add_rcu(&smlp->list, &smack_rule_list);
> -				mutex_unlock(&smack_master_list_lock);
> -			} else
> -				rc = -ENOMEM;
> -			return rc;
> -		}
>   	}
>   
>   out:
> @@ -540,9 +513,9 @@ static ssize_t smk_write_rules_list(struct file *file, const char __user *buf,
>   
>   		if (rule_list == NULL)
>   			rc = smk_set_access(&rule, &rule.smk_subject->smk_rules,
> -				&rule.smk_subject->smk_rules_lock, 1);
> +				&rule.smk_subject->smk_rules_lock);
>   		else
> -			rc = smk_set_access(&rule, rule_list, rule_lock, 0);
> +			rc = smk_set_access(&rule, rule_list, rule_lock);
>   
>   		if (rc)
>   			goto out;
> @@ -636,21 +609,23 @@ static void smk_rule_show(struct seq_file *s, struct smack_rule *srp, int max)
>   
>   static void *load2_seq_start(struct seq_file *s, loff_t *pos)
>   {
> -	return smk_seq_start(s, pos, &smack_rule_list);
> +	return smk_seq_start(s, pos, &smack_known_list);
>   }
>   
>   static void *load2_seq_next(struct seq_file *s, void *v, loff_t *pos)
>   {
> -	return smk_seq_next(s, v, pos, &smack_rule_list);
> +	return smk_seq_next(s, v, pos, &smack_known_list);
>   }
>   
>   static int load_seq_show(struct seq_file *s, void *v)
>   {
>   	struct list_head *list = v;
> -	struct smack_master_list *smlp =
> -		list_entry_rcu(list, struct smack_master_list, list);
> +	struct smack_rule *srp;
> +	struct smack_known *skp =
> +		list_entry_rcu(list, struct smack_known, list);
>   
> -	smk_rule_show(s, smlp->smk_rule, SMK_LABELLEN);
> +	list_for_each_entry_rcu(srp, &skp->smk_rules, list)
> +		smk_rule_show(s, srp, SMK_LABELLEN);
>   
>   	return 0;
>   }
> @@ -2352,10 +2327,12 @@ static ssize_t smk_write_access(struct file *file, const char __user *buf,
>   static int load2_seq_show(struct seq_file *s, void *v)
>   {
>   	struct list_head *list = v;
> -	struct smack_master_list *smlp =
> -		list_entry_rcu(list, struct smack_master_list, list);
> +	struct smack_rule *srp;
> +	struct smack_known *skp =
> +		list_entry_rcu(list, struct smack_known, list);
>   
> -	smk_rule_show(s, smlp->smk_rule, SMK_LONGLABEL);
> +	list_for_each_entry_rcu(srp, &skp->smk_rules, list)
> +		smk_rule_show(s, srp, SMK_LONGLABEL);
>   
>   	return 0;
>   }
