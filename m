Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7C0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F359F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfHTLa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:30:26 -0400
Received: from foss.arm.com ([217.140.110.172]:39076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729421AbfHTLaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:30:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2932344;
        Tue, 20 Aug 2019 04:30:22 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C98A3F718;
        Tue, 20 Aug 2019 04:30:20 -0700 (PDT)
Date:   Tue, 20 Aug 2019 12:30:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v2 03/14] arm64, hibernate: add trans_table public
 functions
Message-ID: <20190820113000.GA49252@lakrids.cambridge.arm.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
 <20190817024629.26611-4-pasha.tatashin@soleen.com>
 <20190819155824.GE9927@lakrids.cambridge.arm.com>
 <CA+CK2bD4zE6eieSW2OLQwOQC7=4ncDc8wK6ZjhDO3Dv+BUqnzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bD4zE6eieSW2OLQwOQC7=4ncDc8wK6ZjhDO3Dv+BUqnzQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:33:31PM -0400, Pavel Tatashin wrote:
> On Mon, Aug 19, 2019 at 11:58 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Aug 16, 2019 at 10:46:18PM -0400, Pavel Tatashin wrote:
> > > trans_table_create_copy() and trans_table_map_page() are going to be
> > > the basis for public interface of new subsystem that handles page
> > > tables for cases which are between kernels: kexec, and hibernate.
> >
> > While the architecture uses the term 'translation table', in the kernel
> > we generally use 'pgdir' or 'pgd' to refer to the tables, so please keep
> > to that naming scheme.
> 
> The idea is to have a unique name space for new subsystem of page
> tables that are used between kernels:
> between stage 1 and stage 2 kexec kernel, and similarly between
> kernels during hibernate boot process.
> 
> I picked: "trans_table" that stands for transitional page table:
> meaning they are used only during transition between worlds.
> 
> All public functions in this subsystem will have trans_table_* prefix,
> and page directory will be named: "trans_table". If this is confusing,
> I can either use a different prefix, or describe what "trans_table"
> stand for in trans_table.h/.c

Ok.

I think that "trans_table" is unfortunately confusing, as it clashes
with the architecture terminology, and differs from what we have
elsewhere.

I think that "trans_pgd" would be better, as that better aligns with
what we have elsewhere, and avoids the ambiguity.

Thanks,
Mark.
