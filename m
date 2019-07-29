Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC58C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410232073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZVoxJO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfG2SeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:34:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43827 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387925AbfG2SeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:34:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so62903973wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpTNef2J2++QNO/OkHVy/yBR1B5TUwAqqnweG/iXLyQ=;
        b=LZVoxJO0kBPqiF/uiAFqrbcV2bFOZTwsBdFA28Xc8nQJSw/oSIaMTOi0CJ/jTHW+kb
         kACkHaaTGZ5nbO7JbvxdhhGQC1iFHZEBGxy/Igms3FH3htza/94TRLm1nZBPT9nmcPIX
         v9S963ibaBpFPqm4rgg0MujYPEqxWeU/d6/97rEBTKPfdGMLcW6ZcrFefJNKbV1H0OS/
         icvQypSExJN8HtE5YcyKj5QcOgKFTxA50dxbjFLH95maIKNImEPobXrcWyik2Buz5FQK
         BOw0crkgXtXYCvOdhJMxsFBd0H614pBW3ZAS7IpKS+PHXoMGpfRDC/MDTFeo/UccetOM
         Bv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpTNef2J2++QNO/OkHVy/yBR1B5TUwAqqnweG/iXLyQ=;
        b=IAW1J+GHHLpRD8G/XIc4edVDafeuyy4YRmMGkr2BaaU5DtvobLkE7Efj9/zoXGXs7a
         DUB2Z45aQ8QTIvNO32YdnyWWaTmjS2PpVuOe6LOqc23CRe73VSAUt1I57KXzEk8GhtQI
         jv/OJ3XtRz7x5rCHWgOWELLSW2UjIf3r8O7gqy8SMi4R2IYOqKUeDD0CQ9jvWVLLb5c7
         QZXfluXjujd239vUzKAOkW1qcV1oD1xMpUh+7+SGAPYxJepGAgJmkhg9oJAc4Z16NaHW
         5EMVV/m3Ri8rLnfKriB2UBM+lSABlAOwg7td7SPGIsu2PWNEPWi9t7T02y+xeJF5CIE6
         l2nA==
X-Gm-Message-State: APjAAAWUvrqZcB/KIP6MO0Cub70CJWtIt/HzPIH3aQ0MfRwV7qjXf4Sx
        1PSPxpJUTHS23Qu4SO+rHaOhyykBAqKiAke7lctWLdJW
X-Google-Smtp-Source: APXvYqzm6XO0MjlmwEOBSDGQInrilKkrrqCvL/4sjBmTp50wT9ZFDcnAsnubc3selGc8g3TuMaB/fX2ZNp0VmcyOQa0=
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr114636138wra.328.1564425262685;
 Mon, 29 Jul 2019 11:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR1201MB003708ADAD79BF4FD24D3445AACB0@CY4PR1201MB0037.namprd12.prod.outlook.com>
 <20190723202735.113381-1-john.stultz@linaro.org>
In-Reply-To: <20190723202735.113381-1-john.stultz@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 29 Jul 2019 11:34:10 -0700
Message-ID: <CALAqxLW0HWJpPUK5JBDhuQ_m3w6teWo6eg1BeEd9YcfSmG+iHQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Check for IOC/LST bit in both event->status
 and TRB->ctrl fields
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Fei Yang <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 1:27 PM John Stultz <john.stultz@linaro.org> wrote:
>
> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>
> The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
> for IOC/LST bit in the event->status and returns if IOC/LST bit is
> set. This logic doesn't work if multiple TRBs are queued per
> request and the IOC/LST bit is set on the last TRB of that request.
> Consider an example where a queued request has multiple queued TRBs
> and IOC/LST bit is set only for the last TRB. In this case, the Core
> generates XferComplete/XferInProgress events only for the last TRB
> (since IOC/LST are set only for the last TRB). As per the logic in
> dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
> IOC/LST bit and returns on the first TRB. This makes the remaining
> TRBs left unhandled.
> To aviod this, changed the code to check for IOC/LST bits in both
> event->status & TRB->ctrl. This patch does the same.
>
> At a practical level, this patch resolves USB transfer stalls seen
> with adb on dwc3 based Android devices after functionfs gadget
> added scatter-gather support around v4.20.
>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Fei Yang <fei.yang@intel.com>
> Cc: Thinh Nguyen <thinhn@synopsys.com>
> Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
> Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Linux USB List <linux-usb@vger.kernel.org>
> Cc: stable <stable@vger.kernel.org>
> Tested-By: Tejas Joglekar <tejas.joglekar@synopsys.com>
> Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> [jstultz: forward ported to mainline, added note to commit log]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> Just wanted to send this out so we're all looking at the same thing.
> Not sure if its correct, but it seems to solve the adb stalls I've
> been seeing for awhile.

Felipe: Any thoughts on this patch?

thanks
-john
