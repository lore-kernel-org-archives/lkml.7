Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA728C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38CB20873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX21WeiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfEOUy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:54:27 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39676 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfEOUy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:54:27 -0400
Received: by mail-yb1-f194.google.com with SMTP id x5so373631ybn.6;
        Wed, 15 May 2019 13:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zGQL9LsQuN8YbfL9CZrmVDIRemP16gWSExM1zmbLHfI=;
        b=UX21WeiKiMm1amsk6NGUYy3M4Nti2lsSKl6MKM6BS+lq8NRd9Cr7qMEOD2LLK1Unmp
         +0qIBD3Bu0wIMILU+QUtXS+zVtqx3xAcOYRfKUtgAAs98u3+RKt1NEnOf7K7mccokB6v
         4R8Ajvm+/t44yfnuO+D4XwV+ZvqmjRXqcPSm1rcb/JX29aq+aT48bDyCq9JEZvDSypxj
         W7MA3b5rC7eY0zKgS6RrDc6n0ZacL9Zk5E4nKCLs65ipLLQ77WAySqWcZfLxvf1wiO7I
         2AL5pBX0Ouo49JzF4OzKP8R9tvEa3CrWmoAtqFbW0uoz6/wPQ1vK9GrB1wy67ugnCj64
         5Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zGQL9LsQuN8YbfL9CZrmVDIRemP16gWSExM1zmbLHfI=;
        b=tcnWCtZu74H43TKKxevglzmkUsST3oXpiltkkbfk88GLp3Mq2m7POukARLeOhcmBVz
         fuJ3AvTkOKWUC5cMAToTytpCzL1xC6JpbAGsAvO/zdBzBangutt1Sq0SDE/3mK33ASG/
         bsHZMX4Z2HvRvLQ3vBY2xFE6uMEVL1cdTvC5Mf1UgWzcaVrWVMryirfx3do8vPkR0VEq
         dBfermx1VbuKtVn/8XwypSMiRpIIMNax5WxG+8vmol8+bPtMGDE/S5XfO6/Z/gTlu+Sa
         8FEQrYbVpQYlMJg+ttvi9dluFSbyNIfeGSMdhL9uGq4RiLabGjFB4xSLPpUlMYbpkn4N
         IStA==
X-Gm-Message-State: APjAAAUn0ac+UUZUCWGHfKGH6x20Fyhhbvf4BSaR/4bwUoPjFvTDJqaL
        miuVZ6VWrKnBQklSTRkB3A==
X-Google-Smtp-Source: APXvYqzRu8lyusD1DkMs23H3rduOlPrjafvFoOkpVG/6eiGHgJpgXgdz7GFWvCdaL01XydqdltxUuw==
X-Received: by 2002:a25:e687:: with SMTP id d129mr20151432ybh.475.1557953665967;
        Wed, 15 May 2019 13:54:25 -0700 (PDT)
Received: from 960 ([69.41.96.247])
        by smtp.gmail.com with ESMTPSA id 75sm1065562ywp.64.2019.05.15.13.54.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 13:54:25 -0700 (PDT)
Message-ID: <39f32949f84185c87b245b594131824b1865d1ee.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] sound: Enable micmute led for Huawei laptops
From:   ayman.bagabas@gmail.com
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Wed, 15 May 2019 16:54:23 -0400
In-Reply-To: <s5hk1erj20h.wl-tiwai@suse.de>
References: <20190513203009.28686-1-ayman.bagabas@gmail.com>
         <20190513203009.28686-3-ayman.bagabas@gmail.com>
         <s5hk1erj20h.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 15:11 +0200, Takashi Iwai wrote:
> On Mon, 13 May 2019 22:30:06 +0200,
> Ayman Bagabas wrote:
> > Since this LED is found on huawei laptops, we can hook it to
> > huawei-wmi platform driver which uses the common WMI interface
> > present
> > in these laptops to control the LED.
> > 
> > I've also made some renames and used product name instead of common
> > name
> > to avoid confusion.
> > 
> > Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> 
> This looks applicable independently from the patch 1?
> If so, it can go via sound git tree while another via x86-platform
> tree.
> 

Yes it is. Will send another one.

> 
> thanks,
> 
> Takashi
> 

