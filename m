Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA17C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531BC2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iE9qoOLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfGPJAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:00:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42996 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfGPJAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:00:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so9098572pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lkUFnw3tfRAr3e/K9WKPjwIamFFWJ4GH53aBPdA3SN4=;
        b=iE9qoOLowk11gGQyNUKy6hX3dzsZULEYSEE9OPgqI7mSLLicdUlU32aTXLzaosOv7o
         Ps4O6zFWL2zCMd3qvOz+NPOOvxudpA4ZoNz1iW7Kfm742WMhzcJgBCItjvxhdXUFEpyJ
         q1nV6IR/pVSafAW3UgifsGzWyaCK13P0JoqyXGZf1ENQ7sW90oBo9k5SJQtD9weyR/nM
         F6NcPidmAxKSquh6UC12UiEPXBGITyV41xeCRd0q7nCLS66gdldBCos0dPIjm88xzghm
         mu0cB9pSTFbkVmGX1VOZzW3LHyZtMnr/kUgpnQ82ctfG0dTDhC3nwPBAwZiAkRnO8wZh
         OCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lkUFnw3tfRAr3e/K9WKPjwIamFFWJ4GH53aBPdA3SN4=;
        b=YhMDt4DNmUV0htjLUWtql1FVy/H3jszBw07JKbeBLA4dmkpeHtd6zIXsUZ9JxMrgpV
         emOKoFSWcYV0j45ErT8DeXE9m3pYi5+j9cmUhxLPLAXIqZfcjQsa9SvqYuxBvTohLRqi
         zl9lnHM8YPXKqK2ALS9n4JuyOM3eNazCxq/TN0XDbGQeQJdcEwl3dvUSTjWGfNkKLtty
         80TRNlBZR/Opb/1Cn3IAPjnRKyjBZP7ibwJb4RJjaB2ee98+kss2eOpbBhqmfG5e1YAR
         S38yX+k8k3ICFlCVm4HEnfPS4RzSCipNEv1h2+D92UPUgbVph7qRHwVbj/nX9fFcaLwU
         HN6w==
X-Gm-Message-State: APjAAAVxR5apeLRuLuKtT8ktY0W5+SvjibSg9RG+kHP5DDEvJLBEE8oB
        2q/qn0daqly2MHs7Z1jkvsMnyA==
X-Google-Smtp-Source: APXvYqyRYVnjwsmXfuDGrvTUNw/8KnmANGhR7WhUa8xiZz7T5T2fm77xuJxrapWCLvklzQ79FgDmQw==
X-Received: by 2002:a63:6c46:: with SMTP id h67mr22406939pgc.248.1563267611013;
        Tue, 16 Jul 2019 02:00:11 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id r6sm12769971pgl.74.2019.07.16.02.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:00:10 -0700 (PDT)
Date:   Tue, 16 Jul 2019 14:30:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     wen.yang99@zte.com.cn
Cc:     rjw@rjwysocki.net, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, mpe@ellerman.id.au
Subject: Re: [PATCH v6] cpufreq/pasemi: fix an use-after-free
 inpas_cpufreq_cpu_init()
Message-ID: <20190716090008.pgddadjzribgbaxw@vireshk-i7>
References: <20190712034409.zyl6sskrr6ra5nd3@vireshk-i7>
 <201907161626465333445@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907161626465333445@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-19, 16:26, wen.yang99@zte.com.cn wrote:
> Okay thank you.
> Now this patch
> (https://lore.kernel.org/lkml/ee8cf5fb4b4a01fdf9199037ff6d835b935cfd13.1562902877.git.viresh.kumar@linaro.org/) 
> seems to have not been merged into the linux-next.
> 
> In order to avoid code conflicts, we will wait until this patch is merged in and then send v7.

Please rebase on PM tree's linux-next branch instead and resend your
patch.

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

-- 
viresh
