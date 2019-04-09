Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B7C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F4620850
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FANu+XNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfDIX3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:29:49 -0400
Received: from sonic314-22.consmr.mail.bf2.yahoo.com ([74.6.132.196]:35019
        "EHLO sonic314-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726947AbfDIX3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554852587; bh=z2c0Wcy4Z8qDvvCxfPe9OubtZvmKSn0akaPPd4lfNWM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=FANu+XNsuuoP9/beMXPRMGAs5isHh51W2wVrRCLoMAieIm/xH78+UTGsabn/h671UDPDZn6cPrFmMCsdV7oZnZCmxeoAiaQqXEyWUZr3+D8L8MmdzBdXBgk+Ed6mpe+L+1OTT+GsrzMttcOt/IO9fStqCOJJWNauvGb5MOuqak+qKMR2BsSJUPdMJ8S5vHInZaAmk9VKBmOZitMDSDadVPLhwXVrHZNqIHI3XXuzrFak3RTLwWnKxnwQ41aJTUqXXCwm3t/NKuaOeJyNs4HpllQTap3AayoMBtc2XjnnjM7BvEaGolkuVeIEsnPLmdibj/qCi7WUMhWY7hC8Y9T3qg==
X-YMail-OSG: v1d2.VYVM1ng2BGnqKGQUrYoWv6KRz.cXJswes5ezIDDvrVYBkqvzymU1hp7nIp
 7XY.LfMGgu1aueaJkl_UUfmSDUu7WOIsAd0PNnUdwe9rtMnDssaFEnRKilR_sTezM0DpY_6Tz1_s
 lnQVtAWEA7nWeW3V0G4gTUw3S1oaCMcj3xmxaTRAS5norUEGhrRsKzmpOZdiK3.on9TKI5TQPKW0
 BjixwZvTVBLYp.jh4x1V22LDZ5CNuMMmCwVPKQAq4O6NagkwGKZOvfoQ4c9i3aCUHqmULD5Pb0Jq
 STil43ZLxDhaWqxiSgs6eiIE_CkD.QAWfiTPpSka7YyPyNA3v286xfl5SduQbrpYza4J_OK0lYrd
 dCdwwwrVc6DyDZfX9RO4VnbHkuA7IN.3gWSQ_sk7FDTcntmI_QjXyToz.zZf_zJROIwAo.isSB6k
 O1_cF5B7EvpJVdxE4u5l8E2GppXEqdEhCvxHic8cWTPw9UOgJ51pJYOuCS.LtP3_c83E7fOGkiuY
 6aQjeyS6zqJ8PBZNw.ACCN86Xn4m9N9TzKkwmayeIT64DFfD5TM1fhU95Z.WHqS72Ui6sYg_ed5R
 ElK5khgn90r1.nI50rkoPIodMiWGSRiKyTATn0eF2q3azoSo4hWnzpyANPTRNK8UQjVAdh.Pixnq
 cbW59WbDAALu3.6aZaIaFjXxQfVsB8BsFG2bnKcJ80MvaLgvS7HDdIn900KFbZM1XAnzpmOfCyGr
 jPGf6hMfT.nF6ZSMW7i6brHaCbJE2bWL91C7A5hPTCRCUBNjr52vfF6pni4RiRIhhNeft3SdWQL2
 zVeXkazD.dn2rQinYerezjQqW7UQ3uTJkB_0rwUxs25SFlTMbQrHu6yMbK2nFPbMVpAKb8ma1ir9
 smv_sVMvMZnSQLLincQMUOqiUqFCjofH5ojG1ljlwZYTbaQ4PKCznIf8dof7YTUCdIkIs9JRBcXw
 tSvavOeCKWpWFaGA7WgPitz11b.D1gJ2BH4gjfRBLxFBcWIbKwHrf3ZYYy8y5jc.SEmYfRRGyPGo
 D8TsN_SJp0iy.nQAVmnS40K2N3h_I2Jo9ppqkq6wb1buoGGCBFdTSSe35v_oMa3LcJ_tLvod0NN_
 lmCtXKcpNP.r98v_xrmX047fcWcPk8NNrkr.P0oRFPTtWG4oWPRp3eHX59zvw9CzyLK3JtIZkkxY
 Arw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Tue, 9 Apr 2019 23:29:47 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp402.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ad12ab9332fd83af7668f17de3152fe2;
          Tue, 09 Apr 2019 23:29:46 +0000 (UTC)
Subject: Re: [PATCH 1/1] Smack :- In this patch, global rule list has been
 removed. Now all smack rules will be read using "smack_known_list". This list
 contains all the smack labels and internally each smack label structure
 maintains the list of smack rules corresponding to that smack label. So there
 is no need to maintain extra list.
To:     Vishal Goel <vishal.goel@samsung.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     pankaj.m@samsung.com, a.sahrawat@samsung.com
References: <CGME20190307093333epcas5p25cc50478585532ea2f7c4a1275b04279@epcas5p2.samsung.com>
 <1551950603-15570-1-git-send-email-vishal.goel@samsung.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5371c205-1e5f-25d5-237a-493d75bc9da9@schaufler-ca.com>
Date:   Tue, 9 Apr 2019 16:29:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1551950603-15570-1-git-send-email-vishal.goel@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2019 1:23 AM, Vishal Goel wrote:
> 1) Small Memory Optimization
> For eg. if there are 20000 rules, then it will save 625KB(20000*32),
> which is critical for small embedded systems.
> 2) Reducing the time taken in writing rules on load/load2 interface
> 3) Since global rule list is just used to read the rules, so there
> will be no performance impact on system
>
> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
> Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>

I have taken this patch in for
	https://github.com/cschaufler/next-smack.git#smack-for-5.2

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
