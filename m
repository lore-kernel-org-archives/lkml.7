Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0094E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbfCZXz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:55:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34625 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfCZXz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:55:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id n68so8849970qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P04cs5uaHO4BE6OlINHXYscLGe9dWYGk7foFB9Ma6MQ=;
        b=XkV5llHxUVB7qdVAachfR71KIxN3/JpZAwouRkzYy4T7p1/rlCbx1RBQZpdMzkxg3t
         f0EYas/F70aio//HGbcn9ZQOi/wSU3xWEH0ua0geLw4ZAAGeVIsQia0/EBA4GgZHaEbG
         qf9OaZdduAxCwwTJkd/66w0DPXLCvb5IYYtusIUHHItHAftGguppP9fGGlth8acR7YzB
         oJfTQ3oNcbIglwzxOe2taqTRyMrRrg77u6hDEHxqUQ2sqvwUpFt4A+PV7/thBtIxnvvN
         yzjWk6OKPL0rBHJh8pe829o2Guf93W2iXsv+3RT8QGT5bkYMhx7uUwnK5vuqAacjxW+4
         sPQQ==
X-Gm-Message-State: APjAAAWvut2B6ARRw1kdOuVvC5fwjnm2HUGQQN7CoxOpcv4UfXuEApgf
        qqMn6WvYrW6cQXiMIq202vStiQ==
X-Google-Smtp-Source: APXvYqxAcifL+uJ3VTiKJ9L4slkNmfdnhyV8yHCCr1J+RTp+kjs+IMKBTYULivlRmVc/oQVYPlpR9Q==
X-Received: by 2002:a37:d85:: with SMTP id 127mr26347746qkn.139.1553644557505;
        Tue, 26 Mar 2019 16:55:57 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::fa4a? ([2601:602:9800:dae6::fa4a])
        by smtp.gmail.com with ESMTPSA id s43sm10686593qth.47.2019.03.26.16.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 16:55:56 -0700 (PDT)
Subject: Re: [PATCH] iwlwifi: mvm: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
References: <20190122152151.16139-24-gregkh@linuxfoundation.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <03bb68be-8e42-a463-2d57-3be051dc2016@redhat.com>
Date:   Tue, 26 Mar 2019 16:55:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190122152151.16139-24-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 7:21 AM, Greg Kroah-Hartman wrote:
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
> index 33b0af24a537..c52cdc538678 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
> @@ -1446,9 +1446,8 @@ static ssize_t iwl_dbgfs_quota_min_read(struct file *file,
>   #define MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz) \
>   	_MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz, struct ieee80211_vif)
>   #define MVM_DEBUGFS_ADD_FILE_VIF(name, parent, mode) do {		\
> -		if (!debugfs_create_file(#name, mode, parent, vif,	\
> -					 &iwl_dbgfs_##name##_ops))	\
> -			goto err;					\
> +		debugfs_create_file(#name, mode, parent, vif,		\
> +				    &iwl_dbgfs_##name##_ops);		\
>   	} while (0)
>   
>   MVM_DEBUGFS_READ_FILE_OPS(mac_params);
> @@ -1483,12 +1482,6 @@ void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
>   
>   	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
>   
> -	if (!mvmvif->dbgfs_dir) {
> -		IWL_ERR(mvm, "Failed to create debugfs directory under %pd\n",
> -			dbgfs_dir);
> -		return;
> -	}
> -
>   	if (iwlmvm_mod_params.power_scheme != IWL_POWER_SCHEME_CAM &&
>   	    ((vif->type == NL80211_IFTYPE_STATION && !vif->p2p) ||
>   	     (vif->type == NL80211_IFTYPE_STATION && vif->p2p)))
> @@ -1537,12 +1530,6 @@ void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
>   
>   	mvmvif->dbgfs_slink = debugfs_create_symlink(dbgfs_dir->d_name.name,
>   						     mvm->debugfs_dir, buf);
> -	if (!mvmvif->dbgfs_slink)
> -		IWL_ERR(mvm, "Can't create debugfs symbolic link under %pd\n",
> -			dbgfs_dir);
> -	return;
> -err:
> -	IWL_ERR(mvm, "Can't create debugfs entity\n");
>   }
>   

Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1691034
of a crash with 5.0 and the user did a bisect which pointed to ff9fb72bc077
("debugfs: return error values, not NULL") because the error checking is
no longer correct in this driver.

Based on https://patchwork.kernel.org/patch/10865839/, it looks like
this is supposed to go in for 5.2 but this needs to go in now as
the error checking is currently broken without it. Can this get queued
for Linus so we can get it in 5.0 stable?

Thanks,
Laura
