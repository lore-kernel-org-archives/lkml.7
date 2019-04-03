Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7730C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892DC20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="LkmBUbge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfDCGPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:15:35 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:38863 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:15:35 -0400
Received: by mail-lf1-f47.google.com with SMTP id a6so10792221lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 23:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+HdJu9Lp9feflXnCA7Y3PSH7/4uTDXjSCjYzVBNsqY=;
        b=LkmBUbgewTcBmYWbegJUiU8yDCTLrbkrNBwT6tOSIPU3eDbi0MBsizLYnDpeqad6/c
         mfbXUIrPWwGx4sveMk/TXkfS+yOFo4tq0aJBf0HziVenZNV+wEtCmwv9KuHIyMRnSFI5
         U5UTJbY9RmiosBZBoVxgGEwSCMiiKYrUp5wAwAepwLPZDqMlwk/x6OYDMue64YgquxFH
         b2wz+Tjc7lFu2nTaJ8RhqxdZ9jCFK85l16Tf1dAVTWCkOIBvkJ/xuSTuCm/ef0eVlyh8
         V7zZYcy8QbjtFMNOrkfoHKwc6TDUpi7GcMKNLE63/9eEIA3ftzDi0JHuv065YDQrBhJo
         Fkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+HdJu9Lp9feflXnCA7Y3PSH7/4uTDXjSCjYzVBNsqY=;
        b=PquMlmhCg6iMZqpafgm894e8XzCLsDRHBZa2I+al+lyI830naukVj2qjijSmpoCYW/
         knYHL8WQNPqHuDEyQkORdAlz/z1PoW0oGUQAGDetKNW4qmbt86xinPqAcLqWcT1xj0ge
         mQHOfWdSnGuJG3X6sGN8PmqJdRxNft69YxCh2iw8+JZyM7ysn6gg76ol1ZuFLCkHO7r1
         TugA4zNRtKgtl7tsh6m2R8wyIRpsnvBlX/H5Gh5W00G3RpwcK2yjU2LAqNkC9+y74EkZ
         Som+F2asj8dyxJK8HVgKWFx/YGs4VKfR/k064VRQSAnvAWbfDtbJ35yMRjdzOrDTDNzu
         RFgA==
X-Gm-Message-State: APjAAAX3noS2Udq7zldx3aLqmvTgoRE7be1z4TDIURykNRDuB6Mhnnmv
        S8n0fM3e14592RYwo1RwYFE8qEvIt29Axs+aGnh57Q==
X-Google-Smtp-Source: APXvYqzIH6yBbkRFMJex+CW4/ajxqi5Kbr+dQDPEpDJIzVGgEmp8c5PoQaupGgDDHVHAiII0Va2921O70MYVl1rVQTE=
X-Received: by 2002:a19:238f:: with SMTP id j137mr38015665lfj.79.1554272132796;
 Tue, 02 Apr 2019 23:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190326090238.23651-1-stevemo@skydio.com> <20190330182923.549949d5@archlinux>
 <MN2PR12MB3373F83DB5A56BEECCF29A67C4550@MN2PR12MB3373.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3373F83DB5A56BEECCF29A67C4550@MN2PR12MB3373.namprd12.prod.outlook.com>
From:   Stepan Moskovchenko <stevemo@skydio.com>
Date:   Tue, 2 Apr 2019 23:15:21 -0700
Message-ID: <CACxMumR2H_dprwmwk5T+UwWUSfRU7oOc+MGh=XMgHsvpadwS2g@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: mpu6050: Fix FIFO layout for ICM20602
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Randolph_Maa=C3=9Fen?= <gaireg@gaireg.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Baptiste,
That's a good catch. I didn't realize the accel-only configuration
included temperature data as well. I've confirmed this behavior and
will send out a v2 shortly. Thanks!
-Steve
