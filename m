Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ED6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54C620872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552939490;
	bh=VxP+vAro5vjl+5TW9HBLtbTDE0dvcAVdcTwI/Q3IDxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N9oGNJKmsIeRiyuBGeN524rH2yk3hKPnH60ZlAltRommi4D6q1S2KBkpqzp4mQiIE
	 oCMEnk4+xbk7OQnamPagHcPK3NLHeqytMJ7+Q8gdCJVaMURIPSLHHfck/ruq1zeQm4
	 QhRxvgP2LiW4IUX0COFKCDE5Xx9L65AbqMev0GmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfCRUEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfCRUEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:04:48 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B3220872
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552939487;
        bh=VxP+vAro5vjl+5TW9HBLtbTDE0dvcAVdcTwI/Q3IDxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PEEzjXBm5j7nwSw8JM/ldmfCzcpFT57siPdMTtdbY84MtjoMZrkjHx7uokqMPyOZO
         Kt2TLhfmS2ozwEo0jMayZRnmZNluZ2MzjgZ0YkWUGtHs/v6VK3hGQfs3Pd6SGNZPEj
         zL5vnk5URz0RvElmW65iL20fcHGi4MYCMOU1AU5U=
Received: by mail-wm1-f52.google.com with SMTP id z11so5863627wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:04:47 -0700 (PDT)
X-Gm-Message-State: APjAAAVgJDKYpmP+T/JQn6/hlvWGaJgfEHgmz0SUF0PIl2+Kn4GvaKVf
        J/QmHG2gesEemOYtLB6m84w+NjK1KHHus3KUIli+hg==
X-Google-Smtp-Source: APXvYqx0Qp0LaqRE7TDSGtKjrBxrV1SRYxrd9ZsByp+J6+nszeCFG/2GlsipIJinh1+fUEuFHdnHaG+CvXROayqeoko=
X-Received: by 2002:a1c:eb14:: with SMTP id j20mr537361wmh.32.1552939486176;
 Mon, 18 Mar 2019 13:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190318104925.16600-1-sudeep.holla@arm.com>
In-Reply-To: <20190318104925.16600-1-sudeep.holla@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Mar 2019 13:04:28 -0700
X-Gmail-Original-Message-ID: <CALCETrXneXdPG246B=Sa4R+MG7r-RwVDA1W3bRPzDwAUCai=xQ@mail.gmail.com>
Message-ID: <CALCETrXneXdPG246B=Sa4R+MG7r-RwVDA1W3bRPzDwAUCai=xQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ptrace: consolidate PTRACE_SYSEMU handling and add
 support for arm64
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 3:49 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi,
>
> This patchset evolved from the discussion in the thread[0][1]. When we
> wanted to add PTRACE_SYSEMU support to ARM64, we thought instead of
> duplicating what other architectures like x86 and powerpc have done,
> let consolidate the existing support and move it to the core as there's
> nothing arch specific in it.
>

In the discussion from the first version, there was talk of some
testing.  Can you put the test cases in question into v3?

--Andy
