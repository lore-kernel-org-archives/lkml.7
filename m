Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5D2C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BD620867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW255EIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfJGI2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:28:20 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:50996 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfJGI2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:28:20 -0400
Received: by mail-wm1-f47.google.com with SMTP id 5so11614960wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vi8i83iMhys619QiytD1LExGsofQRsLapgPmrpICIxs=;
        b=LW255EIWDKQR6jmEVorn7tbvhQRDUk+7Uq+kOw1uX/zTnPUpwhsNLQ1EnCm+x63suW
         WmsSgAoZe54dHi18YFALZnNltJi+9b3Of2M42Z0WLbUfCbrVMqKhVzGbpXZ0z3pLPwSP
         lytOlOSw4riQmSPYFXaI7T3dIefbsx2T+CTZrK3sy8PK0xIvcpbVsyKvZY0GokdajE25
         PJ4sMB2ZGb0Sh8p4ZAIRrK3DQjCw3r0dyDQhLRbJeQrQXABRIKerVwiOBLV2QhdHqpeV
         Fx4AM4jQJJ2E1clcjn9eW7Qd3x1C9uZGwE6m0sec0RCaZAP+BjnxLAcNVBptix8m+GYU
         h+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vi8i83iMhys619QiytD1LExGsofQRsLapgPmrpICIxs=;
        b=G8awv3iANLEEHaozn08b3cWUpX41We1Th96ZqY5gWEogqMQiHKQ5SfwgnZ03Jq+f7C
         xaNa5Dl7veR+FPguSiqN0tgx5OEXHXWuEG2rc40vwdkrGDiHRkWgOP75Pklx0z54jBnN
         Acll38mkklCNldh5kEUSqmKZDAQ61Uisk912CilezBce2h2D+A71kqLks3kjJ2KGFD5u
         qlxwbg0kpcRhiBFj2pO5p1WRj+k67bTh+JwocYVpVDLrPZz0XD+yqwKr5DRpm99xBWa8
         iEDarvYe0NY0E1Lt7k3//KhOnh13KcqzeEuKKu+fzu+XJkOn9IdvwEwZ9X0503JIU5tw
         CAvQ==
X-Gm-Message-State: APjAAAVrZeW7uO4RepG8e+0GYAvhgN23JsVgJVzbVaE0aSfW0N5pUbzW
        vLPXlORj3rjRTlxmVqpUYBw=
X-Google-Smtp-Source: APXvYqyMnHLUB9sDtls7UvPxRun60B6x6ZIQxLudJhjh9AHROWTBeAp7T6UMtzPlyLXK+sWbu8w//w==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr18684898wml.97.1570436896337;
        Mon, 07 Oct 2019 01:28:16 -0700 (PDT)
Received: from ?IPv6:2a00:23c4:f78c:d00:1570:f96d:dab8:76ae? ([2a00:23c4:f78c:d00:1570:f96d:dab8:76ae])
        by smtp.gmail.com with ESMTPSA id p5sm8606794wmi.4.2019.10.07.01.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 01:28:15 -0700 (PDT)
Subject: Re: [BISECTED] Suspend / USB broken on XPS 9370 + TB16
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, andrew.smirnov@gmail.com,
        rrangel@chromium.org, gregkh@linuxfoundation.org,
        kamal@canonical.com, khalid.elmously@canonical.com
References: <2f2f62bc-558f-70d1-44bf-a95334453f8a@gmail.com>
 <294a9515-962a-d64b-c113-b73e9fe85fa8@linux.intel.com>
From:   Carlo Caione <carlo.caione@gmail.com>
Message-ID: <906b91a5-834c-f3a6-9c86-609844a6f867@gmail.com>
Date:   Mon, 7 Oct 2019 09:28:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <294a9515-962a-d64b-c113-b73e9fe85fa8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 09:13, Mathias Nyman wrote:

/cut
> Does the below patch help?  Greg just applied it to his usb-linus branch.
> 
> ac343366846a xhci: Increase STS_SAVE timeout in xhci_suspend()
> Link: 
> https://lore.kernel.org/r/1570190373-30684-8-git-send-email-mathias.nyman@linux.intel.com 

Yes. That patch fixes the issue.

Thank you,

--
Carlo Caione
