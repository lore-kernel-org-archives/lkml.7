Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3083DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F228020835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CF4eeDQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfCDUfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:35:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36050 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfCDUfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:35:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so3849206pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xNmRIXO0MDorylQ6to2ktdfK3KWc9juEpeOkY/XwoJA=;
        b=CF4eeDQZAKbaUGzJA9fQrzNzkO+NVHMbfRrNep/Zh7xnCdV2i2ErmB04CC6jBQqoqk
         hCfP4Dn9cDxs3zfMNFBlmeR7wANSPtqE4t6cu7eeKbr0YwyFvysVuUibBE9E7eAJ41tL
         GqWbKYsVAmzlSdSWYZMozNM/IyRS5pZiqMJ/orvBDADJAw59YjXJH/1MwGFNaLaubEMQ
         TZ4vC7oPA258zLV2nXE3/rplpdeR+ObDgk7ZXMiSm1XnCwHa5tOuu+qqtEGgp77hCQIR
         nkGnJjQ5KOtV6v4FEVwVjzBX962VYSQBtbyINOxVkyNAfPT132cTXxOpIJljqe0XDgy8
         lp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xNmRIXO0MDorylQ6to2ktdfK3KWc9juEpeOkY/XwoJA=;
        b=JyvH6NGWsd5P7v8R18xDyGvoJiVYc4zb1TMWlgTkrY8w1+7s5hsDawJlU4kxlcF9NU
         FRI4geza5HgaL2GfPfpVnRW7nR5t/o1ZOnTthfv9AhbEdT5/pTsTal6yPm1lCZb2iH5W
         a99PoGbdYYvJCiLTV97csW9B69rROiEkXVtjHA1y/b/BXf0w4n8qTWmvOc6r72d2Dczb
         ahBMFHUTB6Bbr1mnEpbHQOedDa71YOVeDEVfgYa0OEp3EXSotI9pXM3RRJaK7QW96krS
         ZsDT0tmw1XmEUcZY67VXFwM/2rwKoalaR6ixZ51fTFPPjRVht6POpmKBYnOmGk7yhqW9
         tKPw==
X-Gm-Message-State: APjAAAXgF2iFi4TMRoAhcl4esc8HjimlpRq0KKdeT6wpR2rdasazRRaR
        NoHE5nE+1DTUkRXDIj00Vjtssw==
X-Google-Smtp-Source: APXvYqxja//u6kgFzU5DvfMkiEewZ3u55h1AEIkISeL6/xSWE/saZvaIZksEJL1uE6MRINFUnKohqQ==
X-Received: by 2002:a17:902:728f:: with SMTP id d15mr22290851pll.156.1551731709722;
        Mon, 04 Mar 2019 12:35:09 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id k74sm13911823pfb.172.2019.03.04.12.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 12:35:08 -0800 (PST)
Date:   Mon, 04 Mar 2019 12:35:08 -0800 (PST)
X-Google-Original-Date: Mon, 04 Mar 2019 12:34:41 PST (-0800)
Subject:     Re: [PATCH 0/3] riscv: Fix debug instruction check and support trap-based WARN()
In-Reply-To: <1551349891-22683-1-git-send-email-vincentc@andestech.com>
CC:     aou@eecs.berkeley.edu, ebiederm@xmission.com,
        Jim Wilson <jimw@sifive.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        deanbo422@gmail.com, vincentc@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     vincentc@andestech.com
Message-ID: <mhng-76c68381-da6b-4b8c-97c9-e38d503b93bc@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 02:31:28 PST (-0800), vincentc@andestech.com wrote:
> The handler for the debug exception will call is_valid_bugaddr(bugaddr) to
> check if the instruction in bugaddr is a real debug instruction. However,
> the expected instruction, ebreak, is possibly translated to c.ebreak by
> assmebler when C extension is supported. This patchset will add c.ebreak
> into the check mechanism. In addition, BUG() is currently unable to work in
> the kernel module due to an inappropriated condition in is_valid_bugaddr().
> This issue will be fixed in this patchset. Finally, this patchset enables
> WARN() related functions to trap the code to help developers debug it.
>
>
>
>
>
> Vincent Chen (3):
>   riscv: Add the support for c.ebreak check in is_valid_bugaddr()
>   riscv: Support BUG() in kernel module
>   riscv: Make WARN() related functions able to trigger a trap exception

I'm finding this patch set a bit hard to follow, and I think it has more diff 
than is necessary.  For example, the first patch introduces a new die() only to 
have it removed by the third patch.  There's also some unnecessary 
non-functional diff, like

    @@ -149,12 +161,13 @@ int is_valid_bugaddr(unsigned long pc)
            if (probe_kernel_address((bug_insn_t *)pc, insn))
                    return 0;
            if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32)
    -               return insn == __BUG_INSN_32;
    +               return (insn == __BUG_INSN_32);
            else
    -               return (insn & __COMPRESSED_INSN_MASK) == __BUG_INSN_16;
    +               return ((insn & __COMPRESSED_INSN_MASK) == __BUG_INSN_16);
     }
     #endif /* CONFIG_GENERIC_BUG */
    
    +
     void __init trap_init(void)
     {
            /*

I like the idea of the patch set, though.  Do you have time to clean it up and 
submit a v2?
