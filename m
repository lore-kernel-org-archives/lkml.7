Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BE7C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4506F2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfHEQDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:03:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39163 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfHEQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:03:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so63187242wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 09:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LwK/9xcoxcLhVd0bC7/eyesTfSVbLSLef7bJ1QJeiPA=;
        b=LVVGRxbhM84p4BY1nflnY85hASNh+Fj1eViiK5GYLqZSj4/WUbcFhBlRjkeoDoo4ca
         a6ErT0PcGG8RxNHYdyN/WdKPY9kdoD3pkN+iel6qPctJGPNYna4LXuJ7oYj8TZ4CiXT8
         TBTIrwQnELZsTrpokVYLn0wkD5PVOnUpOnj0pbXLPu/icnr9AdJy79S2mWgLWA9dSFsZ
         T1ktJ5EV2Y0iL+FGRnn2xqDHa0xfN9FJzG+POlZOrcqfHVXzny66xforW0XcSIEV4R+p
         0ZgRgFKYUQfbhZ3UrAu4NWNkfmwIdQGLlcRYlsxSsR1R+2QyJOxKemtJopwzJ3Y8ttDO
         C5ag==
X-Gm-Message-State: APjAAAX4Z1GpizxSJXC7dKj7ioojAAXRBvEVyM33345hMNkxDutx+bz6
        1Yysb532FKHxaiz6YFe2nt0HTsxIFng=
X-Google-Smtp-Source: APXvYqzGW/23QI5xsDwaQipvdvH1ice7rq/tQKOY4EpSalvG7w4huAOnxqDQnYhgBxpemU160KN5eg==
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr19642061wmc.133.1565020983219;
        Mon, 05 Aug 2019 09:03:03 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
        by smtp.gmail.com with ESMTPSA id n3sm76821109wrt.31.2019.08.05.09.03.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 09:03:02 -0700 (PDT)
Subject: Re: [PATCH v3 11/19] RISC-V: KVM: Implement VMID allocator
To:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190805134201.2814-1-anup.patel@wdc.com>
 <20190805134201.2814-12-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <21bdde39-8d33-6aae-e729-476ce11406a3@redhat.com>
Date:   Mon, 5 Aug 2019 18:03:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805134201.2814-12-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/19 15:43, Anup Patel wrote:
> +	spin_lock(&vmid_lock);
> +
> +	/*
> +	 * We need to re-check the vmid_version here to ensure that if
> +	 * another vcpu already allocated a valid vmid for this vm.
> +	 */
> +	if (!kvm_riscv_stage2_vmid_ver_changed(vmid)) {
> +		spin_unlock(&vmid_lock);
> +		return;
> +	}
> +
> +	/* First user of a new VMID version? */
> +	if (unlikely(vmid_next == 0)) {
> +		WRITE_ONCE(vmid_version, READ_ONCE(vmid_version) + 1);
> +		vmid_next = 1;
> +
> +		/*
> +		 * On SMP, we know no other CPUs can use this CPU's or
> +		 * each other's VMID after forced exit returns since the
> +		 * vmid_lock blocks them from re-entry to the guest.
> +		 */
> +		spin_unlock(&vmid_lock);
> +		kvm_flush_remote_tlbs(vcpu->kvm);
> +		spin_lock(&vmid_lock);

This comment is not true anymore, so this "if" should become a "while".

Paolo
