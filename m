Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A46C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE18220825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSvIk4Ed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEGWXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:23:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41451 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfEGWXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:23:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so8861494pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JOHw2h4WyfdeqecBWC0/iiXTy8donTOhcpgp2J9sTnQ=;
        b=vSvIk4EdOijXKIbUmWx0TMPDlflej3piFu8e+Jx6PFhJP7+snSHmhTywYinYiI1BOa
         46i1Qpw6NrvT603v7l2UA+0fKGbMpBLXH4jcipDVxzGQkwzZzjbW/hibxcFkQqZa4TIm
         7aZyDt3A0UHKtygqFBRth3vQnGlxrE/kGvIYkEJ0PErZ4v7yZY1XXP3fU4UEOca2TauH
         v0AY2uwG8dXuefNsp6Pp47la9Hz55w8SmlX56BoQkiua+M2L62Vg4uvHYpTHCdKdpbLX
         Wjwy+NO3QfMblucBDT+6U1tCIekfLOI7Lz0ljDtivyeMYvE9uBLtk5fpKU+MWzgCOMOb
         rQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JOHw2h4WyfdeqecBWC0/iiXTy8donTOhcpgp2J9sTnQ=;
        b=KU0G5TZhGnkJDggZVMmrguBx/eVnTy1hTDZLM+YbZ4uwUYHOV4YcSEY8oehhUrnthm
         oekuxsABG+u12noQisXNVxmzacOanmBifqVOmnqU1FZehViEhxjPg/viGxQNOv1485df
         rhWudObmqpYRSJl9TBQjNk68EZGbb6rh1WMcU8KY/4kDEHCRyhIX1OUv24k8KKaV+fdQ
         b+u9NalncxyQWIPquWjZE5uZzeionDDP9k1g4+H9eeYqddEVbe3mANBglKP/aqt75VLf
         81gnRwRZ7YKN1+/s3Ul+gMgW+W4o4Aflp0wSnd2ToHEyYY6Vd1VCPsVJkGg1WMyoC7Ey
         IgYQ==
X-Gm-Message-State: APjAAAWNCbFdYHrurizKFQu2AaSFEtP7fi6q9yWBrOwhwVRdcTyuBqQq
        74QNM1ToMlEEJ0eP7tBuylU=
X-Google-Smtp-Source: APXvYqzBkTd5yf+Lj1mGYorifVu73EKwCvtafjIH+u/EGe+ZhtZyFI7DI2NtItE9xU9g6C3iwgnLvg==
X-Received: by 2002:a17:902:b614:: with SMTP id b20mr6128707pls.200.1557267819675;
        Tue, 07 May 2019 15:23:39 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id i1sm703349pgj.70.2019.05.07.15.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 15:23:39 -0700 (PDT)
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older
 Chromebooks
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190503174730.245762-1-dianders@chromium.org>
 <CAGXu5jL9cJ+8scZ+Cg9yqdc9+rb563xs-qVjXXuPRJYjNa4Y8w@mail.gmail.com>
 <CAD=FV=WcjfUwH62bHVELOmzViv7d329r6+HfPqAyXMjKCO7LeQ@mail.gmail.com>
 <30361ae7-36a6-0858-77ec-40493ef44b98@gmail.com>
 <CAD=FV=U5heONCv=W5x6cL_JAmJaeDrjMa0CnQ=UVu+DTZZBNKQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <90974ece-ab3a-7f5a-7d71-bd8a0d1d5aec@gmail.com>
Date:   Tue, 7 May 2019 15:23:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=U5heONCv=W5x6cL_JAmJaeDrjMa0CnQ=UVu+DTZZBNKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 5/7/19 3:19 PM, Doug Anderson wrote:
> Hi,
> 
> On Tue, May 7, 2019 at 3:17 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/6/19 4:58 PM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Mon, May 6, 2019 at 2:10 PM Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> From: Douglas Anderson <dianders@chromium.org>
>>>> Date: Fri, May 3, 2019 at 10:48 AM
>>>> To: Kees Cook, Anton Vorontsov
>>>> Cc: <linux-rockchip@lists.infradead.org>, <jwerner@chromium.org>,
>>>> <groeck@chromium.org>, <mka@chromium.org>, <briannorris@chromium.org>,
>>>> Douglas Anderson, Colin Cross, Tony Luck,
>>>> <linux-kernel@vger.kernel.org>
>>>>
>>>>> When you try to run an upstream kernel on an old ARM-based Chromebook
>>>>> you'll find that console-ramoops doesn't work.
>>>>>
>>>>> Old ARM-based Chromebooks, before <https://crrev.com/c/439792>
>>>>> ("ramoops: support upstream {console,pmsg,ftrace}-size properties")
>>>>> used to create a "ramoops" node at the top level that looked like:
>>>>>
>>>>> / {
>>>>>   ramoops {
>>>>>     compatible = "ramoops";
>>>>>     reg = <...>;
>>>>>     record-size = <...>;
>>>>>     dump-oops;
>>>>>   };
>>>>> };
>>>>>
>>>>> ...and these Chromebooks assumed that the downstream kernel would make
>>>>> console_size / pmsg_size match the record size.  The above ramoops
>>>>> node was added by the firmware so it's not easy to make any changes.
>>>>>
>>>>> Let's match the expected behavior, but only for those using the old
>>>>> backward-compatible way of working where ramoops is right under the
>>>>> root node.
>>>>>
>>>>> NOTE: if there are some out-of-tree devices that had ramoops at the
>>>>> top level, left everything but the record size as 0, and somehow
>>>>> doesn't want this behavior, we can try to add more conditions here.
>>>>>
>>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>>
>>>> I like this; thanks! Rob is this okay by you? I just want to
>>>> double-check since it's part of the DT parsing logic.
>>>>
>>>> I'll pick it up and add a Cc: stable.
>>>
>>> Hold off a second--I may need to send out a v2 but out of time for the
>>> day.  I think I need a #include file to fix errors on x86:
>>>
>>>> implicit declaration of function 'of_node_is_root' [-Werror,-Wimplicit-function-declaration
>>
>> Instead of checking "of_node_is_root(parent_node)" the patch could check
>> for parent_node not "/reserved-memory".  Then the x86 error would not
>> occur.
>>
>> The check I am suggesting is not as precise, but it should be good enough
>> for this case, correct?
> 
> Sure, there are a million different ways to slice it.  If you prefer
> that instead of adding a dummy of_node_is_root() I'm happy to do that.

Yes, I would prefer to avoid adding a dummy of_node_is_root() if the
alternative is reasonable (and if I understand, you are saying the
alternative is reasonable).

Thanks,

Frank

