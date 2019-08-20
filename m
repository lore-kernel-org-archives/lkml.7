Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3E8C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A602332A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="hC0JAsdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfHTVNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:13:54 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41826 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbfHTVNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 17:13:53 -0400
Received: by mail-pg1-f170.google.com with SMTP id x15so15202pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=COQZdiCjrrFEcVsjX6I0ZXViUiK8K/UbiYsifMm0lpQ=;
        b=hC0JAsdkBmeIWNFNGmEqP7K6ub18gh9k8irPi0ipsaSpo2Njrhbu2TNSS6iz9xkoUx
         8+vfxlezmNEJ/P1DmD1AjBrRH6Nu1r6GOxw3cV/qUT5DneI5Sq7G9JdwYlZxed6+DKS2
         ETvxGt6zDFQmPAp2B5rM8dRzOe6MJBnSX4h+BKjmk/v6rdC0mF3UCcK45nalrCpbjhiF
         gtIn8xIcRf4hi+z7kA4MNTge1cfpoxotHHMvU3oXcegbfYkAKS+npWOIA7PjNtwbuMVe
         qLKlU1DLGnbmD0ZSQphipIJKc4IN+qbHzaG7cWXQ7gXFW6siwxqVW6p2KJ8hVgG8TNrg
         v5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=COQZdiCjrrFEcVsjX6I0ZXViUiK8K/UbiYsifMm0lpQ=;
        b=RQ6JXDg7N4FZHAbav3ZUEtPOrER6uctNrR5ujlrL3YikQOewvJjRxeQuZ6k3wCebSh
         2DG+2xcH3O6kzONOn8T3qN7PdIsAhrAM8DAyOdkSI+0Yvac4lXCNN1obOmPkT/W04DoI
         K32Rx4I7UMA7uvNr/IKYJYBjl7/gYaPz6Z6YKZHziLoMOfwyldp3FnjWrZgHC3fSR1q1
         ens5jOTyUYfmlmlO8AZhJB7M50dOoxwlcrv1MGrjnWtkejgZr5mD4s4yWkviqOxhXHHJ
         +gzCGbig8ytMBxkAnpvAssp9fp/8FUwOhcqQfXMMpEM1TxESE/FzQQlQzS2q9/gsftAr
         dZ6Q==
X-Gm-Message-State: APjAAAXDUV90atzYgpHX9ciDr6raaqXHA2sq4eBqjTJDE5dOCkt4K6ps
        xhX66w9TY1RE7TFwaALT+0LoKA==
X-Google-Smtp-Source: APXvYqxN2pWdjLTCMpSWcz4etD41MHjyNMwBGq8Bot7/an/+ofeqXS2Yajq0JcfiwaEbFq09SwbeWQ==
X-Received: by 2002:aa7:9197:: with SMTP id x23mr31790435pfa.95.1566335632670;
        Tue, 20 Aug 2019 14:13:52 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id a6sm22890774pfa.162.2019.08.20.14.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 14:13:52 -0700 (PDT)
Subject: Re: USB: gadget: f_midi: fixing a possible double-free in f_midi
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Yavuz, Tuba" <tuba@ece.ufl.edu>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        stable <stable@vger.kernel.org>, Felipe Balbi <balbi@ti.com>,
        linux-usb@vger.kernel.org
References: <20190820174516.255420-1-salyzyn@android.com>
 <20190820201515.GA20068@kroah.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <c96a0121-eb12-9449-44eb-0d2e09ccef92@android.com>
Date:   Tue, 20 Aug 2019 14:13:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820201515.GA20068@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 1:15 PM, Greg Kroah-Hartman wrote:
> No signed-off-by from you?
>
> Anyway, this is already in the 4.4.y queue and will be in the next
> release.
>
> thanks,
>
> greg k-h

Ok, thanks! I will stand down.

-- Mark

