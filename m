Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58680CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F922077C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfJUR1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:27:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfJUR1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:27:15 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB84785542
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 17:27:15 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 6so1768933wmj.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o4xeYtdnmb8NdCuVzBbUa7fVvwoUzqqrPHBPV9zqYVk=;
        b=HxC4VG8Y3N9xV0rA1VdRmtQqobikCZ7qxTSlRPy7r2bZP7FFuCe826s/tfKNbFkKNC
         lfQyZtf0Z2+HHvhqkkQ66ajbV2WzpL+cGAoKY+hP1PTkHqx0+D9bjKL93DPpIeHtSKyn
         t6oEQGiduhzhDMbRtAFy6QaZ6D/IUVtWcXZ1040QLSkc3nWO84rdiVxqb++zhporoiIJ
         7ESYyFBeWkGoMRcYcLl/CM4LD5h3GbdejXJcOHcLYdJBueLjAq22xqm/FYiAvurecQRH
         ARkGQbOE+0oQFcoLivuxOOl/xXVOZzWRpnZoZEcNZknTkNwOSPtg2+UJAMFCsfbZutZM
         BpDw==
X-Gm-Message-State: APjAAAVg5T+paprcgqmDVvHrbWebwpBWMH8HQHvhVkjLQbyuH7QvC4c3
        vEZw2pRCY1SxbagcHESePu44A98DpefsLFjA/wzzyZzBv+PtepsYSB5FgyRznu7nC8JebtZL4PH
        CoFMk9Ufhs+vIeudPAkZ5b2Xe
X-Received: by 2002:a1c:a556:: with SMTP id o83mr21599611wme.0.1571678834219;
        Mon, 21 Oct 2019 10:27:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzipaLfA3kUVnqB/RRSN8weGdEW5X/KaWu7Reo2wlZT9NrXTpU395PLRqKuErbW+MMVjo6+Dw==
X-Received: by 2002:a1c:a556:: with SMTP id o83mr21599580wme.0.1571678833914;
        Mon, 21 Oct 2019 10:27:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:847b:6afc:17c:89dd? ([2001:b07:6468:f312:847b:6afc:17c:89dd])
        by smtp.gmail.com with ESMTPSA id t8sm15118590wrx.76.2019.10.21.10.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 10:27:13 -0700 (PDT)
Subject: Re: [PATCH v9 20/22] RISC-V: KVM: Fix race-condition in
 kvm_riscv_vcpu_sync_interrupts()
To:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191016160649.24622-1-anup.patel@wdc.com>
 <20191016160649.24622-21-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1d2e9514-235e-183e-b4fc-d3becc9ce471@redhat.com>
Date:   Mon, 21 Oct 2019 19:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016160649.24622-21-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 18:12, Anup Patel wrote:
> +	/* Read current VSIP and VSIE CSRs */
> +	vsip = csr_read(CSR_VSIP);
> +	csr->vsie = csr_read(CSR_VSIE);
> +
> +	/* Sync-up VSIP.SSIP bit changes does by Guest */
> +	if ((csr->vsip ^ vsip) & (1UL << IRQ_S_SOFT)) {
> +		if (!test_and_set_bit(IRQ_S_SOFT, &v->irqs_pending_mask)) {
> +			if (vsip & (1UL << IRQ_S_SOFT))
> +				set_bit(IRQ_S_SOFT, &v->irqs_pending);
> +			else
> +				clear_bit(IRQ_S_SOFT, &v->irqs_pending);
> +		}

Looks good, but I wonder if this could just be "csr->vsip =
csr_read(CSR_VSIP)", which will be fixed up by flush_interrupts on the
next entry.

Paolo
