Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34014FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0C421925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571279719;
	bh=WEQi3xqYKsiBa7+9EaRvYX5iGkUaUogniECZB1KQPA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T5qGmDeVauVCUshN5ivyyD/p/ZsVfbXLpT6p6aJformtZ3vMtJcmj5YNNTRfeTrLG
	 Ho4f3xxoatkA74aSyo54w8Yw1gFs5nhvn9QkNJXabD7YIV+efMgbctOul+1IXUDgPY
	 WoPkhD55sLoXA7kPGqHjvMgrWiwUHTK1ST62OxE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407195AbfJQCfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:35:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33656 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfJQCfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:35:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so374739pls.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 19:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=43Gf/yYAFtrG7sahRKNPNsaeIiTcM4HYV2zVSsTuMgM=;
        b=uC7Vc/WysZhZwIufEcQ9BSUBExUtbHBjD0SyBw3hjnip9P+qfHf9eZMmyDAu3QIYGF
         py2ou30e8LIIBkOdRyOU2EN1WR5/mF9hNC+Rej1JeO3pk8lQo3YHXj8jg8zaPH7H0uPh
         lFUbtK0DHQybV60bXDqC4qFDmSJIMUrZwcQQd+tbrCaHFwm03KsrudjaiU0+92OzR+Jw
         OHM79n1msDQVHyaEZfZvbTd+buCbInlrEOg5sAAkOySveijdZQ2XyLl7ESILyr/Z23nS
         bpoxJSMPcJC0QicDERtfnVBkyI0c6CaxaRoGiTi0/uyeQwV74VkcL9mdE54MHjwsQSLi
         Rgkw==
X-Gm-Message-State: APjAAAVDzlqWcCX0rH7pjU6TKD/gS4nT6dmHOJ4/M+/KzfY0E+rufbot
        /1VpcS/6zaXqBYDAXoTbwBpUEA==
X-Google-Smtp-Source: APXvYqxCTrUaZ2Kzs6nPSDuu9xgpUljXDq1m15jGwEzGZUZcbW3oIL9sEqdR7CTQCU6NCtDaZLsMIg==
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr1437108plr.277.1571279716458;
        Wed, 16 Oct 2019 19:35:16 -0700 (PDT)
Received: from localhost ([2601:647:5b00:424:6361:2bd9:c43a:bc72])
        by smtp.gmail.com with ESMTPSA id f62sm442225pfg.74.2019.10.16.19.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 19:35:15 -0700 (PDT)
Date:   Wed, 16 Oct 2019 19:35:14 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v7 0/3] add thermal/power management features for FPGA
 DFL drivers
Message-ID: <20191017023514.GA31676@archbox>
References: <1571031723-12101-1-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571031723-12101-1-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 01:42:00PM +0800, Wu Hao wrote:
> Hi Moritz and all,
> 
> This patchset adds thermal and power management features for FPGA DFL
> drivers. Both patches are using hwmon as userspace interfaces.
> 
> This patchset is created on top of 5.4-rc3, please help with review to see
> if any comments, thank you very much!
> 
> Main changes from v6:
>  - update kernel version and date in sysfs doc.
> 
> Main changes from v5:
>  - rebase and clean up (remove empty uinit function) per changes in recent
>    merged dfl patches.
>  - update date in sysfs doc.
> 
> Main changes from v4:
>  - rebase due to Documentation format change (dfl.txt -> rst).
>  - clamp threshold inputs for sysfs interfaces. (patch#3)
>  - update sysfs doc to add more description for ltr sysfs interfaces.
>    (patch#3)
> 
> Main changes from v3:
>  - use HWMON_CHANNEL_INFO.
> 
> Main changes from v2:
>  - switch to standard hwmon APIs for thermal hwmon:
>      temp1_alarm        --> temp1_max
>      temp1_alarm_status --> temp1_max_alarm
>      temp1_crit_status  --> temp1_crit_alarm
>      temp1_alarm_policy --> temp1_max_policy
>  - switch to standard hwmon APIs for power hwmon:
>      power1_cap         --> power1_max
>      power1_cap_status  --> power1_max_alarm
>      power1_crit_status --> power1_crit_alarm
> 
> Wu Hao (2):
>   fpga: dfl: fme: add thermal management support
>   fpga: dfl: fme: add power management support
> 
> Xu Yilun (1):
>   Documentation: fpga: dfl: add descriptions for thermal/power
>     management interfaces
> 
>  Documentation/ABI/testing/sysfs-platform-dfl-fme | 132 ++++++++
>  Documentation/fpga/dfl.rst                       |  10 +
>  drivers/fpga/Kconfig                             |   2 +-
>  drivers/fpga/dfl-fme-main.c                      | 385 +++++++++++++++++++++++
>  4 files changed, 528 insertions(+), 1 deletion(-)
> 
> -- 
> 1.8.3.1
> 

Series applied.

Thanks,
Moritz
