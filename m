Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7068FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422CA20872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUldVnQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUKcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:32:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30002 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726170AbfKUKcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574332341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrTHs4p3T+JKjlu+h7xt1dI+m5b6CE2uVtQ3GAVVvOw=;
        b=DUldVnQ2fyObtzlJX2rU5Qrdjeu4H6MarYCbheRtAVVGdTDLHGTEg8DA1oeHfBAt/4d2Kj
        kg9CBvd+Rd1nb97qdudrztkaRSkz/hB0OZEGX+dVYyziSasiGwF2gOoMyWLh0OVb1FxLr7
        VufaH+N9UtMFDGTfhcqge75L0tDwkrw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-KANdjcvZM0CTsGKLC6RCeg-1; Thu, 21 Nov 2019 05:32:17 -0500
Received: by mail-wr1-f69.google.com with SMTP id k15so1794487wrp.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sEn8j3qljU8xWoRVJTyVCoe4Ukb/pvIY7iS6FUz/GhE=;
        b=jCGsjbng06sxvbofAdcc4yrWWbK/OEnNAwG/UszlCTezN0cYqBLc5c56wVcmSvd0lk
         3N9u6Ug6TFVCwHfFPEMuCBAr+uz6V3VExQmuitGe9sU8Q5MNdpg3LnSn+KlmJ5UTjyiD
         b99To/+G/26GFMOvhzrnhvNnZFMrtNxbSbgLnzO26ITkTJXAL60r064dKm01I6W+Cyv+
         aAOFdzO8pLGnfn2pnqIUNiwPNZbwU3ve7kwPDfLUJIm646lplQSLFVCsEAgkU98c/UVu
         B69CELBO4w2FR90oGfLPC1nt6FWJEGkgZ3pyxYgGCANz4rZGV6L4aA1GyG6Y3BvauM0V
         5azQ==
X-Gm-Message-State: APjAAAVBpi/5L7TmA3OA2MC0Ew2+SHvE4kAtNPMyKmxtqSCD97auxAnh
        KNrQ6QMsTb+yd7bheM0GQJHTMuvZY+W11BUHehzNlMx5qf7KuSJ9CKh9YbpY+xatU6OF4xVqcqK
        Y2vwypk6T+JEUvGjKKyEkMvu8
X-Received: by 2002:adf:c786:: with SMTP id l6mr9233680wrg.45.1574332336464;
        Thu, 21 Nov 2019 02:32:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxq5NnzjVp/mYmPkleWYkx2uLA3odk4o+lmaU+fJmK8nj8HEelO6h1h7dbCYbr1aeiS7Tu0g==
X-Received: by 2002:adf:c786:: with SMTP id l6mr9233640wrg.45.1574332336183;
        Thu, 21 Nov 2019 02:32:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id w17sm2876245wrt.45.2019.11.21.02.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:32:15 -0800 (PST)
Subject: Re: [PATCH v7 8/9] mmu: spp: Handle SPP protected pages when VM
 memory changes
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-9-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac9aa811-7a20-8481-7ddc-a2e39899cee1@redhat.com>
Date:   Thu, 21 Nov 2019 11:32:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119084949.15471-9-weijiang.yang@intel.com>
Content-Language: en-US
X-MC-Unique: KANdjcvZM0CTsGKLC6RCeg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 09:49, Yang Weijiang wrote:
> +=09=09=09/*
> +=09=09=09 * if it's EPT leaf entry and the physical page is
> +=09=09=09 * SPP protected, then re-enable SPP protection for
> +=09=09=09 * the page.
> +=09=09=09 */
> +=09=09=09if (kvm->arch.spp_active &&
> +=09=09=09    level =3D=3D PT_PAGE_TABLE_LEVEL) {
> +=09=09=09=09struct kvm_subpage spp_info =3D {0};
> +=09=09=09=09int i;
> +
> +=09=09=09=09spp_info.base_gfn =3D gfn;
> +=09=09=09=09spp_info.npages =3D 1;
> +=09=09=09=09i =3D kvm_spp_get_permission(kvm, &spp_info);
> +=09=09=09=09if (i =3D=3D 1 &&
> +=09=09=09=09    spp_info.access_map[0] !=3D FULL_SPP_ACCESS)
> +=09=09=09=09=09new_spte |=3D PT_SPP_MASK;
> +=09=09=09}

This can use gfn_to_subpage_wp_info directly (or is_spp_protected if you
prefer).

Paolo

