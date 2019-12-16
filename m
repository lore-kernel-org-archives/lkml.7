Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5B2C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6FD2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLPUlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:41:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53519 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfLPUlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:41:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so728585wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 12:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4LEUOClJGFBZXXimsbAlWTuczz0gXm2nGBL4FN9Bv/4=;
        b=L+FevWT7WJ/o5Va3JiGWwhkTUUtMCwUjWFMF527ebC8iKrpOgfN/FSH+sjvv0masMS
         X2gWiJpZqXDJmEbwC+9s1I+V1Akdp5T0nrcLIDRDuC+8K6k9BEBWDB718t3l2aT6K8Mx
         wGzMjcvUMiRUW3GtCYlMIiMz6DJZMizVTOEAbqt/AjaF2Y0+ZXL9yOkpfRFoJgnHYQ3R
         sB8p5d2mGCiZyLUSV6R+WBU8ykK3ywGXJ+ZYy9Htdf4NQiqZWuwe6WYnSENQvnggPiq7
         qaxRxolzVc8IguL/kl97C3/HSD3AQ2tko0mArXlmKL8ZN157R2dM4uwWxP9Y12qoasGT
         9aHg==
X-Gm-Message-State: APjAAAWlcXW+nfBWlPjxwApyNzGLgEwMEGguFzv3T7GkIStyrdTnDRqk
        hwuttjVt1LyYC1A1/hfmiPc=
X-Google-Smtp-Source: APXvYqxbj7wa/3nG3xbSmpvEUqc+RDkNVQ++hJser00UJyvc40nYH9YoURVBkO0nn1m04737kSMJDA==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr924437wmj.105.1576528894763;
        Mon, 16 Dec 2019 12:41:34 -0800 (PST)
Received: from a483e7b01a66.ant.amazon.com (cpc91200-cmbg18-2-0-cust94.5-4.cable.virginm.net. [81.100.41.95])
        by smtp.gmail.com with ESMTPSA id f1sm23611224wrp.93.2019.12.16.12.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 12:41:34 -0800 (PST)
Subject: Re: [PATCH v4 2/6] arm/arm64/xen: use C inlines for privcmd_call
To:     Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org,
        sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk,
        andrew.cooper3@citrix.com
References: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
 <20191204232058.2500117-3-pasha.tatashin@soleen.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <b3a6359a-e7df-b47b-f50d-31b716fae191@xen.org>
Date:   Mon, 16 Dec 2019 20:41:32 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191204232058.2500117-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 04/12/2019 23:20, Pavel Tatashin wrote:
> privcmd_call requires to enable access to userspace for the
> duration of the hypercall.
> 
> Currently, this is done via assembly macros. Change it to C
> inlines instead.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Stefano Stabellini <sstabellini@kernel.org>

Reviewed-by: Julien Grall <julien@xen.org>

Cheers,

-- 
Julien Grall
