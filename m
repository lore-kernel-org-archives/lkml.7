Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B4AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965FD205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADqRLNmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKUKE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:04:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37187 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKUKE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574330695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlHxf+tx+YK13zm2NVKqdVjZssAdpFxw/aWrK1/1hfg=;
        b=ADqRLNmdoCMO2iQFH8Bjjv3AaBw2N2CPeBKQ1jewDMZPJMN7pdeUeVYMOdlJy4xWbVT4ck
        ubHh2SKh0cXSvJoq1ixsT1jVPKClk7SeAZDrED2liZzLR/ey4668VlDwlmCOuudwNFNt9R
        QbK0kkkuQv1s9jC9Isi4sqzQsw/m0HM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-NJltggpqNIe7wV4alt7cDg-1; Thu, 21 Nov 2019 05:04:54 -0500
Received: by mail-wr1-f70.google.com with SMTP id a3so1794673wrn.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=14cqlJbT4+OSkrklIS+IpnOGoM9sdQwDr0naWLYs+xA=;
        b=mmo4Fq8R0byf8LGrSz4mDCjboEgt2ZDQp7uVehHQDzThTCMQ75kfh81WsF8G/iovd4
         YU0cnB56kB929W0W41BZpDgc5aPOPf7NBmjg3yJQWU840KyyYLQDY5y+JlGyikkUADsi
         IjS+9oUdRNAOamqYAc2a9t6Ob71AY+3Kc1pdGt1thVXI4sCNz+Sy/p/tNcLaZdOJrVlp
         5BNBwEKhJQvMwij/lgJVYYZ789AdcE1lDs8rQ+5F4MB0HRp9DsN+Ld5l/NdLYHD3B7lE
         FRzVmbl3d7fbK5zDoG3F7f0I3zWAl0oqa8gAOaRJhs9ce2QsX6QKkfS0c3yMwBQ080o1
         ebrQ==
X-Gm-Message-State: APjAAAWCbWaSZa45z3rQiI87Yp334UK2T37PMv3hhJud6tkzWu8mm2LQ
        Ui9Exg0SZpBCAoTVDXIu4phfDnGBxD7Y2/zIN+BZ2g3w7V8wFwk7KhWY19e8cX69oxEp6MB+yv/
        VyTR7kDaDVDurGzj8nr4ym+NR
X-Received: by 2002:adf:f987:: with SMTP id f7mr9459666wrr.284.1574330693358;
        Thu, 21 Nov 2019 02:04:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzUISdg7RN9omhcEa8sb+8q2vJs6Xcjtp9Kl1BiFvArAIiyHPbyqyJaaaxsnVetKraFLYN3FA==
X-Received: by 2002:adf:f987:: with SMTP id f7mr9459632wrr.284.1574330693096;
        Thu, 21 Nov 2019 02:04:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id j67sm2428269wmb.43.2019.11.21.02.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:04:52 -0800 (PST)
Subject: Re: [PATCH v7 2/9] vmx: spp: Add control flags for Sub-Page
 Protection(SPP)
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-3-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6e71e7b-b708-211c-24b7-8ffe03a52842@redhat.com>
Date:   Thu, 21 Nov 2019 11:04:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119084949.15471-3-weijiang.yang@intel.com>
Content-Language: en-US
X-MC-Unique: NJltggpqNIe7wV4alt7cDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 09:49, Yang Weijiang wrote:
> @@ -228,6 +228,7 @@
>  #define X86_FEATURE_FLEXPRIORITY=09( 8*32+ 2) /* Intel FlexPriority */
>  #define X86_FEATURE_EPT=09=09=09( 8*32+ 3) /* Intel Extended Page Table =
*/
>  #define X86_FEATURE_VPID=09=09( 8*32+ 4) /* Intel Virtual Processor ID *=
/
> +#define X86_FEATURE_SPP=09=09=09( 8*32+ 5) /* Intel EPT-based Sub-Page W=
rite Protection */

Please do not include X86_FEATURE_SPP.  In general I don't like the VMX
features word, but apart from that SPP is not a feature that affects all
VMs in the same way as EPT or FlexPriority.

Paolo

