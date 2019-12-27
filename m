Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8A3C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 15:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52CB20882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 15:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kvHRUg69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfL0P7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 10:59:47 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:44742
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbfL0P7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 10:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577462384; bh=FVttW5VmUmFN84YGnACvUaxEaLbRGOXmyploTeNCVWg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kvHRUg69NLYt4Ka4LmMCKcUDfFrp51X50Cee2s0foJDWIzOsdf3uuwrWOqzJEkGMyKRWxIcUNa8VlKqpuDXtY7IYqJTmsvkzyDAmKKeDcuVNffFzx73gokmwqNJES7S905nGmRqBnMH8lr9AB+shBpl9yKO7yeztJgO4zpoeQU+pwW0YXhUVKyw4NhyVjlBF7u0nuCz4d/M9xLmVYO+57u5uPmozXOUS84ng5G49sirS/pS8imLp1QSzRr0aM9mBGx86j61niyefj+HEdW7LC0eKZhkgYBuNzrfs5IXR6kOqUXkqAC6A+WMG3mJw48+FY0JY9m4KT3xINqksZxkjaA==
X-YMail-OSG: ufnA69wVM1lAjuY3SOr7wEmoZzdR8btyYkxYZyWBbRBSC0YfZXyGfwNEDMCRCIE
 LZhuKOyM1R7UwGUpb.lQWJFtJQb97JIBGQXCR9fzlARYSldU1hlNc15KileQpsokfLlPzwNVOeBL
 8x_UYwfkMbaTLSkQcfX1FIhhJjJJy1.0y5JLqg3WSBUfk0wx1kO6ZutnnhKsoLWNDninxZ8cM0ZY
 wKHsuh6aztvtt0whTSFzusEhCWgNlSSzuU8TTQOv_Nui0fujmNLKLUM.dega_AemCUTxmyrq.wHa
 Yx_3rUkEJXaooi0fluhRwfsklQ8dNQRij01XZi6i59sRLNAXAh8MhHdz8AS4e7IW8znbYefczfgW
 l54fN6nt5kgS1_yBMhnUXmDYb2wVNIA8rM0l6RvIg6niEMbGLbLL_f6PYiGRNjDJz18hBtJtppKa
 EpBdNhwJGtYovgV8kMnqyrcHFwcLVHCBgCeAcy5erl_qcFkLowJipzCP85nhqHZgsT6kMNrBUdqb
 6H4Z4K9SlHUvZzumtN5G.LcCkUeKuNc.U8PiQ.1z9uEY9g0a7MnM5JY8hNhF_S0Fd2NnytFxNMy3
 __.0COy7LXL6Zi.bTXXzBOQgKq_NBVMHF0c7WVYpnOMlCCzVqx9U73pmvdHcgLHey35eobK2FY3H
 Sx_P5RWvU5FCCTXM5Uqmh3cnV92_qLF5PWFu7LsGgfKNTodbkKVNl1bIYeKhp21af3gJsUDQn34j
 9ufOZxHsepkDEDoVlRv1jquPeSN1iXqubw8Q0QeVLCfaHtnUcpxenSEfInzLhlNmNuOsh_MaOw4I
 2Bevxcxsquodi.l64V1v88qC_1qmPvVzYl_tTLnN41.1VE3_PJKUapTDor7O62hHI23H3OOwCIC8
 X7e451J8R_4X_RFKlMK.r0SiWhko.qfxNKxJoXd31I2JiIQyTA2k6uOURO5ANHC3H79.WUum3n4w
 3LyrrV7A5oyGiTow7fN7t843P_O0sQKn78jy7u4plkH3vakIoE8gARTHthdFQeueYxQsm_TLnevj
 mStjVtUOKrzfTF0xEvDkpF5OSQvj6jonrWBsTuDqHA2KbQTTHxoHNcub4SgsEIBWAb7yCjJ4HTZt
 eNck2AZzwFUCP1s.7P7iSKKH_a8DDgucornTa7xLFz5WrDI8nqWvlMzDOE.gG54SRFCLjvuGgngv
 uxJB2fEreczFQ9GGWNoZIY9izbUWF_FYFr3Bj8gNLuTeI7Gvxl1.2mV.vPsvQOPvhvuLPcSp6Gj_
 AKjKEiFIKHdueCZSTq_MxOrVeOEr5.7uCLMI4Y.2btPq65AdZwX6ZhtwLOpRB9uHbMSPW0y3nTRg
 8Kyf3VzPTFE18G5VoLNBrACW_RXcjCXTNQnhkVYrs3lsKY_LNau4E7C0KQ44JFJXwLKPwhvlvCE6
 KWa2CuHkMCZ4jrA3wp35fQQfd.9tARRSxNP3VXv_tjGCEXABVitzeUxY6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 27 Dec 2019 15:59:44 +0000
Received: by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 73bb6c9437a9ce8f2b23727bbd0fb4ac;
          Fri, 27 Dec 2019 15:59:41 +0000 (UTC)
Subject: Re: [PATCH] Signed-off-by: wenhuizhang <wenhui@gwmail.gwu.edu>
To:     wenhuizhang <wenhui@gwmail.gwu.edu>
Cc:     James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Micah Morton <mortonm@chromium.org>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20191227041214.24064-1-wenhui@gwmail.gwu.edu>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <af2cb126-6697-7439-371a-948958cea891@schaufler-ca.com>
Date:   Fri, 27 Dec 2019 07:59:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191227041214.24064-1-wenhui@gwmail.gwu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/2019 8:12 PM, wenhuizhang wrote:
> selinux/lsm-common: reorder and format security hooks
>   	Changes to be committed:
> 		modified:   include/linux/security.h
> 	Details:
> 		- add default hook for security_cred_getsecid

What is this for? Who uses it?

> 		- group hooks with functionalities and get coherent for orders

Clean-ups should be separate from "real" code changes.

> ---
>  include/linux/security.h | 46 +++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 3e8d4bacd59d..14f580e37b24 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -462,10 +462,6 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
>  	return 0;
>  }
>  
> -static inline void security_free_mnt_opts(void **mnt_opts)
> -{
> -}
> -
>  /*
>   * This is the default capabilities functionality.  Most of these functions
>   * are just stubbed out, but a few must call the proper capable code.
> @@ -605,6 +601,9 @@ static inline int security_sb_alloc(struct super_block *sb)
>  static inline void security_sb_free(struct super_block *sb)
>  { }
>  
> +static inline void security_free_mnt_opts(void **mnt_opts)
> +{ }
> +
>  static inline int security_sb_eat_lsm_opts(char *options,
>  					   void **mnt_opts)
>  {
> @@ -679,20 +678,6 @@ static inline int security_move_mount(const struct path *from_path,
>  	return 0;
>  }
>  
> -static inline int security_path_notify(const struct path *path, u64 mask,
> -				unsigned int obj_type)
> -{
> -	return 0;
> -}
> -
> -static inline int security_inode_alloc(struct inode *inode)
> -{
> -	return 0;
> -}
> -
> -static inline void security_inode_free(struct inode *inode)
> -{ }
> -
>  static inline int security_dentry_init_security(struct dentry *dentry,
>  						 int mode,
>  						 const struct qstr *name,
> @@ -710,6 +695,19 @@ static inline int security_dentry_create_files_as(struct dentry *dentry,
>  	return 0;
>  }
>  
> +static inline int security_path_notify(const struct path *path, u64 mask,
> +				unsigned int obj_type)
> +{
> +	return 0;
> +}
> +
> +static inline int security_inode_alloc(struct inode *inode)
> +{
> +	return 0;
> +}
> +
> +static inline void security_inode_free(struct inode *inode)
> +{ }
>  
>  static inline int security_inode_init_security(struct inode *inode,
>  						struct inode *dir,
> @@ -982,8 +980,10 @@ static inline int security_prepare_creds(struct cred *new,
>  
>  static inline void security_transfer_creds(struct cred *new,
>  					   const struct cred *old)
> -{
> -}
> +{ }
> +
> +static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
> +{ }
>  
>  static inline int security_kernel_act_as(struct cred *cred, u32 secid)
>  {
> @@ -1249,12 +1249,10 @@ static inline int security_secctx_to_secid(const char *secdata,
>  }
>  
>  static inline void security_release_secctx(char *secdata, u32 seclen)
> -{
> -}
> +{ }
>  
>  static inline void security_inode_invalidate_secctx(struct inode *inode)
> -{
> -}
> +{ }
>  
>  static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>  {
