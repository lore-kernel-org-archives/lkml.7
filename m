Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB4AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4B421473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557771536;
	bh=0D70YYCaYJ/0FfOh4xzmgNQF/8UOkldQ6uPFbgG5pwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w0709qNAbeIIrbdyyoqfY2MRZlcafHDk2LMgAh4EEGsb5xAiKE2e7ucrsjjOm0vud
	 /8OP6H2MVSYE6aaiCU27+/r7akg9SOQTvhHBPYiDW7zdHR+4A7pTDd09dFgs/xDqjG
	 W/7Ph4XO9XgBmSRnlz0e99KX9knNc3Jy0L4rd8Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEMSSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfEMSSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:18:55 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14E6521707
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557771534;
        bh=0D70YYCaYJ/0FfOh4xzmgNQF/8UOkldQ6uPFbgG5pwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VJfYnS+5yGbxOPZ/IrGIvPvGQ3MWsey8Zcw2ynEdyFK0bMhb6EA9kn+qh0dub8jNy
         BUnM34hwwZ1Svmkf5b+KeyY5QW3SWsWXC0ncGsSlKjnU7m5z/A5Z5cT9X6y3liCLay
         edErDf2BS2T6yENCy2PLIQTWiBRyIZLCTwIbQJ9Q=
Received: by mail-wr1-f54.google.com with SMTP id r4so16346572wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:18:54 -0700 (PDT)
X-Gm-Message-State: APjAAAXENqr5fBjR/w6DHo41ki2Ayba0+TdnjAR30e9OL83xmfVzGcIM
        p5QDVagGB2EKELjU7wa2vd/hz1DCunF+vB+f1DB+Cg==
X-Google-Smtp-Source: APXvYqzMD+jfx2qmw89VL/y5TnHwYxBELfM91Gqw/WyfcWG/E3PFqI1sA/Of9WWBUTt1ciqS571lZ9PBkV9nJFeVHas=
X-Received: by 2002:adf:ec42:: with SMTP id w2mr17777817wrn.77.1557771532684;
 Mon, 13 May 2019 11:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <1557758315-12667-1-git-send-email-alexandre.chartre@oracle.com> <1557758315-12667-19-git-send-email-alexandre.chartre@oracle.com>
In-Reply-To: <1557758315-12667-19-git-send-email-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 May 2019 11:18:41 -0700
X-Gmail-Original-Message-ID: <CALCETrWUKZv=wdcnYjLrHDakamMBrJv48wp2XBxZsEmzuearRQ@mail.gmail.com>
Message-ID: <CALCETrWUKZv=wdcnYjLrHDakamMBrJv48wp2XBxZsEmzuearRQ@mail.gmail.com>
Subject: Re: [RFC KVM 18/27] kvm/isolation: function to copy page table
 entries for percpu buffer
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kvm list <kvm@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 7:39 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> pcpu_base_addr is already mapped to the KVM address space, but this
> represents the first percpu chunk. To access a per-cpu buffer not
> allocated in the first chunk, add a function which maps all cpu
> buffers corresponding to that per-cpu buffer.
>
> Also add function to clear page table entries for a percpu buffer.
>

This needs some kind of clarification so that readers can tell whether
you're trying to map all percpu memory or just map a specific
variable.  In either case, you're making a dubious assumption that
percpu memory contains no secrets.
