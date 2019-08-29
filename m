Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844DFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FE22339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfH2SVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:21:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52596 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbfH2SVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:21:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id t17so4705395wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9wemDLG+al8uBFQtCufV5oYzqlZQzmNTZtOsaYBmOL4=;
        b=mXix5R/GKhH05FxQiYlol0h1tWjIzt5XdJQ0MMUCI7ZstwYK6iNcBjk4rhx3juw+Xt
         sSujIkJNknqbTKOgrZoxrPJQ5f5Gt2q3ooastPNh5U684/KIDMpkit7xJRalb7eNm7Sd
         sVaxAOKly/ZaGLjXfqnClz7TBvfQC2F5iLkmROSSlrZF3uKsOfCvk7WibCKpOCphh/hB
         xJDlqpBukLX8j0yuY1F1tRXZ86Kblsjd+39lB2cl3H52aOeoksicjVuce4wXcEVP3VlZ
         r143+0osapSmwBqFdYnMj5s6p8GU99jh0ZcdurztswZOTYsOIONfaXlDJ6XN62GlzKXm
         8f8w==
X-Gm-Message-State: APjAAAWdG9wfSftwQrmMzFUV29m1HemipQqj5dQ8frSXUIuGYc0Ns8Rl
        c1MLtRF7z4giyY/uhDp7HANX2HfL
X-Google-Smtp-Source: APXvYqxs9hGhMd3GCtvD6OwjDmG0XpiTouttfQ4gQX2eJSe1yrPiPLw9KxNZ1T6jPMpg7kAE1PRLxw==
X-Received: by 2002:a1c:2d4:: with SMTP id 203mr13320824wmc.105.1567102867216;
        Thu, 29 Aug 2019 11:21:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id c187sm5655385wmd.39.2019.08.29.11.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 11:21:06 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
Date:   Thu, 29 Aug 2019 11:21:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826075916.GA30396@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> You are correct that this information can be derived from sysfs, but the
>>>> main reason why we add these here, is because in udev rule we can't
>>>> just go ahead and start looking these up and parsing these..
>>>>
>>>> We could send the discovery aen with NVME_CTRL_NAME and have
>>>> then have systemd run something like:
>>>>
>>>> nvme connect-all -d nvme0 --sysfs
>>>>
>>>> and have nvme-cli retrieve all this stuff from sysfs?
>>>
>>> Actually that may be a problem.
>>>
>>> There could be a hypothetical case where after the event was fired
>>> and before it was handled, the discovery controller went away and
>>> came back again with a different controller instance, and the old
>>> instance is now a different discovery controller.
>>>
>>> This is why we need this information in the event. And we verify this
>>> information in sysfs in nvme-cli.
>>
>> Well, that must be a usual issue with uevents, right?  Don't we usually
>> have a increasing serial number for that or something?
> 
> Yes we do, userspace should use it to order events.  Does udev not
> handle that properly today?

The problem is not ordering of events, its really about the fact that
the chardev can be removed and reallocated for a different controller
(could be a completely different discovery controller) by the time
that userspace handles the event.
