Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E0BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C932087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbfC0Brh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:47:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36619 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbfC0Brg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:47:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so1409592qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 18:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l0+FE3R7y4eKhOfGWYrRGcNP1DJMRU69lrfnv9T01WQ=;
        b=CNm8PzT/DoRYQXj/i0UZTYDH7hwFlxDP78KPxVIzRKKO84lliZ0h941r/Lq3po8gxU
         67xM+JKpg3XfBzfF21tzzF3O9cGNrdkcKrkI5ir4OnT2AuV5OfqSO7J6CyHEBVbvbQYD
         4AhQePIgKSUBU19aP6q/M4WNIakEsR2dWrYziE9IHAx6ZDnRKMeSfBg8L9bVQ+A+QzaA
         UjwOpf56DMjbOmIOXdjgchmOmEWpo0QRtklJFzQyWFjLIGOkgxaWN3zGqXvUDwIhcQMr
         2/bZKMJdAwH5Iubosr6GQP2k4X88g1ZKiuTSXodPF9K1Ywf4XrGthvr1ktak7M1k5bxI
         xUMg==
X-Gm-Message-State: APjAAAXA3MIFh+m2yMyu1p5hRjlN0sKCYcpWnwzRLoPZ9x2Y/y0yfcCr
        I3nqtR7wKj11AvdaaY9juLLTEg==
X-Google-Smtp-Source: APXvYqwUl9nDggK/cWu3GjYJTURBKiTm0ezea0atblaMfeYcmQDFnWO1/g+cGSmTE6zhmUBmHKlHaw==
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr19046824qtn.45.1553651255916;
        Tue, 26 Mar 2019 18:47:35 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::fa4a? ([2601:602:9800:dae6::fa4a])
        by smtp.gmail.com with ESMTPSA id m41sm3790039qtb.58.2019.03.26.18.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 18:47:35 -0700 (PDT)
Subject: Re: [PATCH] iwlwifi: mvm: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
References: <20190122152151.16139-24-gregkh@linuxfoundation.org>
 <03bb68be-8e42-a463-2d57-3be051dc2016@redhat.com>
 <20190327012600.GA3649@kroah.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <5660d50d-6cbf-3b36-6e6c-312b1617ed23@redhat.com>
Date:   Tue, 26 Mar 2019 18:47:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190327012600.GA3649@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 6:26 PM, Greg Kroah-Hartman wrote:
> On Tue, Mar 26, 2019 at 04:55:54PM -0700, Laura Abbott wrote:
>> On 1/22/19 7:21 AM, Greg Kroah-Hartman wrote:
>>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
>>> index 33b0af24a537..c52cdc538678 100644
>>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
>>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
>>> @@ -1446,9 +1446,8 @@ static ssize_t iwl_dbgfs_quota_min_read(struct file *file,
>>>    #define MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz) \
>>>    	_MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz, struct ieee80211_vif)
>>>    #define MVM_DEBUGFS_ADD_FILE_VIF(name, parent, mode) do {		\
>>> -		if (!debugfs_create_file(#name, mode, parent, vif,	\
>>> -					 &iwl_dbgfs_##name##_ops))	\
>>> -			goto err;					\
>>> +		debugfs_create_file(#name, mode, parent, vif,		\
>>> +				    &iwl_dbgfs_##name##_ops);		\
>>>    	} while (0)
>>>    MVM_DEBUGFS_READ_FILE_OPS(mac_params);
>>> @@ -1483,12 +1482,6 @@ void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
>>>    	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
>>> -	if (!mvmvif->dbgfs_dir) {
>>> -		IWL_ERR(mvm, "Failed to create debugfs directory under %pd\n",
>>> -			dbgfs_dir);
>>> -		return;
>>> -	}
>>> -
>>>    	if (iwlmvm_mod_params.power_scheme != IWL_POWER_SCHEME_CAM &&
>>>    	    ((vif->type == NL80211_IFTYPE_STATION && !vif->p2p) ||
>>>    	     (vif->type == NL80211_IFTYPE_STATION && vif->p2p)))
>>> @@ -1537,12 +1530,6 @@ void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
>>>    	mvmvif->dbgfs_slink = debugfs_create_symlink(dbgfs_dir->d_name.name,
>>>    						     mvm->debugfs_dir, buf);
>>> -	if (!mvmvif->dbgfs_slink)
>>> -		IWL_ERR(mvm, "Can't create debugfs symbolic link under %pd\n",
>>> -			dbgfs_dir);
>>> -	return;
>>> -err:
>>> -	IWL_ERR(mvm, "Can't create debugfs entity\n");
>>>    }
>>
>> Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1691034
>> of a crash with 5.0 and the user did a bisect which pointed to ff9fb72bc077
>> ("debugfs: return error values, not NULL") because the error checking is
>> no longer correct in this driver.
>>
>> Based on https://patchwork.kernel.org/patch/10865839/, it looks like
>> this is supposed to go in for 5.2 but this needs to go in now as
>> the error checking is currently broken without it. Can this get queued
>> for Linus so we can get it in 5.0 stable?
> 
> That's odd, I can't see how the error checking is wrong here.  If the
> directory is not created, an error will be returned, which should be
> able to be handled by debugfs_create_file().
> 
> So with this patch does the error go away?
> 

The full patch didn't apply cleanly and I didn't try to backport it
for the reporter to test. I was going off of the theory that if the
patch was there it would fix the problem.

What I _think_ is going wrong is dbgfs_dir is actually an errno value:


         struct dentry *dbgfs_dir = vif->debugfs_dir;
         struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
         char buf[100];

         /*
          * Check if debugfs directory already exist before creating it.
          * This may happen when, for example, resetting hw or suspend-resume
          */
         if (!dbgfs_dir || mvmvif->dbgfs_dir)
                 return;


so this blows up in the snprintf

         snprintf(buf, 100, "../../../%pd3/%pd",
                  dbgfs_dir,
                  mvmvif->dbgfs_dir);

Unless I misunderstood what the debugfs error change did. I think this
also means the if check needs to look for IS_ERR and not just !dbgfs_dir.

Thanks,
Laura

> strange,
> 
> greg k-h
> 

