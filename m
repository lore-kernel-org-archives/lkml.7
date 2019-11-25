Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A68C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F63820659
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBdkVkNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKYUPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:15:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41662 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKYUPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 15:15:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id p26so7893410pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 12:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=llUK3i1niv16cdWbDXAJs5ExZTAv/m6WEktgyyWhXFY=;
        b=sBdkVkNWGS2oMMZ5VHQnxSumwiuiFLL9lafIAOLv0iKt3GASV3WSq0rYT/uebrKX63
         qdzz8PRq2Nk9UIULE0VshuC0AcNzDrEKtHXjj9PNcAWwmzrT5TUoecZ6P8+YVWTEfw+a
         mm0uVpP15wLODSCrweSFajEWRHyQT3qFEWm7XpteFURSS1aG6N1ILzXBJAhoGey64ezS
         CCKT2jEtLahenEfKXt4dnwmxvLx/Xj4wQuWK5LGg7ZLZ4ox19SrZv3rvz1DNqY3KbCcK
         qMX9bVzWMDi8krT/hyScSsMnGw6DpEG4cb3jpR8hdBI1VcK+NnyRgIqvZzW9pMOn3Nf3
         TaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=llUK3i1niv16cdWbDXAJs5ExZTAv/m6WEktgyyWhXFY=;
        b=ruVJcyIrIG+kNv/e0pBOBP19TziatTf7Igd1KE2cE5V9m2oJSn/WhlipnLhlT4aGVD
         mrDVCTo8+3CpsilsP344WT/E4/tGQ7lhfQgF827ivy8lju+WA4+fbNGedCqsoYvuS0DF
         qtVR3EAdsCj9Ec5ih3e1vzlrrllzhVO9SZa5Ziz6LzNpiQdI1KYYucLsWdW6Q3RFW4wo
         2evGsURnCEmOR5X/jsi6qEWEjmrFUx5U2RPtCYtbvE2uFBP5xIw1OVntp8yR7XZotkF9
         LfJEaJb6cJrwxQzVK+2qCqEH68eJTPl1Xr2diMsb12Qcx68vm/fbIiYdDnNUs8E2cVTo
         94Vg==
X-Gm-Message-State: APjAAAWmTDY/nx+MNUKzbSQK94jo3ULcg361bN+fsY8xNqHT+bK2sBX9
        GCf0lSDsK8Sttx8rADo8171rwPyH2lM=
X-Google-Smtp-Source: APXvYqyZPq2SCYgm5IpPqo73rjzD2UOI94gts+jmIlldOuHcEpGsyKoai6uHV7RRYwrToJ34bPSUxQ==
X-Received: by 2002:a63:561b:: with SMTP id k27mr34910392pgb.253.1574712907967;
        Mon, 25 Nov 2019 12:15:07 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id x25sm9734258pfq.73.2019.11.25.12.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 12:15:07 -0800 (PST)
Date:   Mon, 25 Nov 2019 12:15:07 -0800 (PST)
X-Google-Original-Date: Mon, 25 Nov 2019 12:03:38 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v2] riscv: Fix Kconfig indentation
In-Reply-To: <alpine.DEB.2.21.9999.1911221853330.14532@viisi.sifive.com>
CC:     krzk@kernel.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-c0078b00-1f6a-4286-bb43-404f17574494@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 18:54:28 PST (-0800), Paul Walmsley wrote:
> On Thu, 21 Nov 2019, Krzysztof Kozlowski wrote:
>
>> Adjust indentation from spaces to tab (+optional two spaces) as in
>> coding style with command like:
>> 	$ sed -e 's/^        /\t/' -i */Kconfig
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Thanks, queued with Palmer's Reviewed-by: (which I believe would apply
> equally to this version)

Ya, it does.
