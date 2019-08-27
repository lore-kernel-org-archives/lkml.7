Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D74C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2862173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566894080;
	bh=J12+v8LGE7E2g0HNfJIg/NUzehxfXpJt2IVybk5yVbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GSEZAEPQU9+J2GLb4MWxYfH2nZp3Yt5Mj4Cm328HOuS/PJTSgXLwtJxdCA6+Zyzwl
	 OJbT4d8gGckvOQ1XkJVpE7jBTodW1zk1yUEgxEWGJB5s0cgwkdc7VDSwoTdlOJ+VsC
	 cvu9hkgNrlJkn9GUyRAwXCATALGi/KhKahQ+89d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfH0IVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbfH0IVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:21:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 587C1206BA;
        Tue, 27 Aug 2019 08:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566894077;
        bh=J12+v8LGE7E2g0HNfJIg/NUzehxfXpJt2IVybk5yVbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xiGuHuOgjLBY0dEcgVizUT+DK4uPzERmdVRV8zd0caQbNyhwBN35YCHUpOR2E7zOk
         tJ9wcuEwKR4COff7sj3K8jLu99hCSk8I0TL690fiXHUIEm5G9wTqLbOp5FfpLn5mG6
         ZKAEraz30+qLJK0wI95fKkkwLmdCCq5blOkiiQ/I=
Date:   Tue, 27 Aug 2019 09:21:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Yonghong Song <yhs@fb.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Dou Liyang <douliyangs@gmail.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, rcu@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH 14/16] include/linux: prefer __section from
 compiler_attributes.h
Message-ID: <20190827082106.mvatxqebpawuh4g5@willie-the-truck>
References: <20190812215052.71840-1-ndesaulniers@google.com>
 <20190812215052.71840-14-ndesaulniers@google.com>
 <20190813083257.nnsxf5khnqagl46s@willie-the-truck>
 <CANiq72mXvuVdO2i9gobmh9YeUW4bhe7YnqQc6PaZrbqua1DoYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mXvuVdO2i9gobmh9YeUW4bhe7YnqQc6PaZrbqua1DoYw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 02:51:46PM +0200, Miguel Ojeda wrote:
> On Tue, Aug 13, 2019 at 10:33 AM Will Deacon <will@kernel.org> wrote:
> >
> > -ENOCOMMITMESSAGE
> >
> > Otherwise, patch looks good to me.
> 
> Do you want Ack, Review or nothing?

You can add my Ack if a commit message appears.

Will
