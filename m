Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC130ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863C32089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrgOx2BW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436841AbfJQRwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:52:02 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33734 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbfJQRwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:52:02 -0400
Received: by mail-yb1-f193.google.com with SMTP id h7so985037ybp.0;
        Thu, 17 Oct 2019 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Y+ZwNbvDgBSzQVKHdX0fwos/mJZYR5WoyveqVfS1nI=;
        b=hrgOx2BW7c9paa25PYU8TkqKkBUyoDNTJgrZdCxqC6tzleyg/+9TLcsbhCRix45vy0
         S4js+1MENCUK1An61x04rGWacyC4T30NzcnnLFSs3DAC+NeTB8c+fw302gYJr61OhPaR
         IYOH1T8HRl9/XstjQrInWC2HiPKAO+Ph/S6+TY2qiOenHy5+2gE9NRLKtdk9iazYbyGT
         LdzYDvyiwdZL+AKzzESaCpqU5eCDYyH8FctAVXIqxv46AYnEAKgu7zE38KM/0F3vfvtq
         SjZDbSeqjurYQMNMKp6hHyWJM2SROHHb+5iVE6azQUYfVmD90DooLcVCbirp48hHcqVd
         1aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Y+ZwNbvDgBSzQVKHdX0fwos/mJZYR5WoyveqVfS1nI=;
        b=ndVxLgG6GH819GQEiuY+q4mvev+2xD04yGDuOe2zz3c4tRXwWAhc/8cSwXzv5cg/N6
         dSLjvrRKkV88tqqUe+8msyqTS+/dW+cBMGsxP21FgY9+cCvN5pt0P9eiMVcs5biqSV4i
         AkZLUjFKRl5Ogy1nBdwaxol8+/WcpUt8lMyYU58ApqFZD9ngQZHHHa/xFw89A80JkhY0
         gTCeNw14zuq380UElKB5QnA5MTbcgMd6txmvcndb+n8Xj+Kf9Hme5VKouGLnC5y2EWHW
         9a08SrjZqWUBt3jg/Q4lyqWXrWviy2UqiBiYDporeQ35fBvWSu7/qeeeZuXl+vo7MNVd
         ebBg==
X-Gm-Message-State: APjAAAWa+imt2CFKu4kxaq/fJnmaGSTpK8SLIpbczXikXFE5hw4+pfUK
        T4++Lxt1HX/aiHohTtMi3AuIC43l
X-Google-Smtp-Source: APXvYqx47R2Mzj1mI0CyeN1V3OZmrTNj71UhsM+SdJuHR+2Z1YzBpsFr+vO0xnCD2roudDZ1i23avA==
X-Received: by 2002:a25:514:: with SMTP id 20mr3353863ybf.422.1571334721244;
        Thu, 17 Oct 2019 10:52:01 -0700 (PDT)
Received: from [192.168.1.62] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z66sm39771ywz.78.2019.10.17.10.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 10:52:00 -0700 (PDT)
Subject: Re: [PATCH] of: unittest: fix memory leak in unittest_data_add
To:     Rob Herring <robh@kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191004185847.14074-1-navid.emamdoost@gmail.com>
 <20191015194105.GA24758@bogus>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <2558667a-6820-fd68-bd03-64b9fb467c7a@gmail.com>
Date:   Thu, 17 Oct 2019 12:51:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191015194105.GA24758@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/2019 14:41, Rob Herring wrote:
> On Fri,  4 Oct 2019 13:58:43 -0500, Navid Emamdoost wrote:
>> In unittest_data_add, a copy buffer is created via kmemdup. This buffer
>> is leaked if of_fdt_unflatten_tree fails. The release for the
>> unittest_data buffer is added.
>>
>> Fixes: b951f9dc7f25 ("Enabling OF selftest to run without machine's devicetree")
>> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>> ---
>>  drivers/of/unittest.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Applied, thanks.
> 
> Rob
> 

Academic since already applied, but:

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
