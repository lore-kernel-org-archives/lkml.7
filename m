Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01556C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20FA206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGaL3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:29:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36877 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:29:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so65411485eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 04:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jCrdi6iZTx1g9vmHzrs+JIRim7u1VeaT1iHowsMbIo4=;
        b=rJukYSBONc8Fj+b3Wtsut9rWwPKuoTjQAL2wSXaJjQkwhxYdTPxfscWWfFY84CE4Y9
         lxbdUk7H31p2YNfLuUzxfz3wBzxh4xBHNLtvuJwf2KcWZ9WUGsusCUwonq7uuUjU6R0F
         NAFa2IqoikxLSJBnxT6IFK7lf+EjAss9j11ITLMz2qc7lAczGG5ChmarrPWiMxK3EkJb
         NwxBKTjKMWNphD4+paJ2c83NRLBA2LqAJcKiop6wQQsHlciRGeeKx+FuuGn1cdelkraH
         9zvj6NcnjIKGO9yLmBJ5IQJuOJ9E6gPruiQX9um7NwJaE+flux37xV9W0ZNcXUvtuedP
         g1EQ==
X-Gm-Message-State: APjAAAUeOQcq6IAYcXJk3nOtPot4L6voiaqSu9L05tWCOU4yGM2qYFQI
        5D56KXWEyomUKR39cWuAt5Mkng==
X-Google-Smtp-Source: APXvYqwOYCoIM0Y8Cm011SWOMkANiaWqTnW6O1Cb1YzR1A/upfKO6SxW+Kdwc9RPcZ48XkcHgVo05Q==
X-Received: by 2002:a50:b343:: with SMTP id r3mr103636766edd.16.1564572575321;
        Wed, 31 Jul 2019 04:29:35 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t7sm4548498edw.87.2019.07.31.04.29.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 04:29:34 -0700 (PDT)
Subject: Re: [PATCH] HID: logitech-dj: Fix check of
 logi_dj_recv_query_paired_devices()
To:     Petr Vorel <pvorel@suse.cz>, YueHaibing <yuehaibing@huawei.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20190725145719.8344-1-yuehaibing@huawei.com>
 <20190731105927.GA5092@dell5510> <20190731110629.GB5092@dell5510>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
Date:   Wed, 31 Jul 2019 13:29:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731110629.GB5092@dell5510>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 31-07-19 13:06, Petr Vorel wrote:
> Hi,
> 
>>> In delayedwork_callback(), logi_dj_recv_query_paired_devices
>>> may return positive value while success now, so check it
>>> correctly.
> 
>>> Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> OK, not only it didn't fix problems with logitech mouse (see below),
> but removing mouses USB dongle effectively crashes kernel, so this one probably
> shouldn't be applied :).
> 
> [  330.721629] logitech-djreceiver: probe of 0003:046D:C52F.0013 failed with error 7
> [  331.462335] hid 0003:046D:C52F.0013: delayedwork_callback: logi_dj_recv_query_paired_devices error: 7

Please test my patch titled: "HID: logitech-dj: Really fix return value of logi_dj_recv_query_hidpp_devices"
which should fix this.

Regards,

Hans
