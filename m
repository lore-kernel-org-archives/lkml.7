Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20976CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70D02083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7qx1LEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJaHbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 03:31:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34862 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJaHbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 03:31:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id c8so3445596pgb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/OaD+n4RK+536QUBy36ir8RP75mwlPP5f6kEuftwjtU=;
        b=Z7qx1LEIZ5Ll6ttkf9Ff+fegiLs/eMTnUnVWTXXMZiM4TQdWR+tMgPsdamUgz6JMln
         Gw3b+XNArHUwhpLDUE0P84ND0Dot5zTurUBQkMxiLMH8t0gH+VNsCcJsGp54UP2DDO5K
         ekYzWvmWx7V59KEAkHcaKLwh+wr+kCQMK7kfVNdGD8v4mNpZDmk1sw9Z9C/V6g7Dsv93
         qA89wa8PHBABpbyPrf30UAz5u/gqq/8kfaVDB7HvA2ZQh+kGCHIAPCRKFtpPdF8+o1iM
         gloM4GWYpKoKKqeqrCAMgSJ8g51LWMDUD4UFZgZcqXhWv/kSupvDx7sLuJbxwnUBS40R
         cZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/OaD+n4RK+536QUBy36ir8RP75mwlPP5f6kEuftwjtU=;
        b=JldqNap+JOPIFIFUaIP4/39On0yRUDXaqTtSeO0XvnlBgVA+2MLm9w85lt62gpkoVE
         PUm0gqGHZJo1dwqoHJieaYGj6l90ysVxiAyI2dHHeVEFzl5eRqCkn0DUZGvAfQvZ1AGk
         UI3dHvuldBP/6jYK/pVR//RFjVAZrWsFuArergxWfbZ3axZdB7wqgkUPh3ppTpwnRAXw
         GNhSzbnYJzVcJ5AdmNHAdhCh2MRcSFMaHJLcsueO/yDmGoSTcl62M4BefhuILrAWfQsn
         /slhFoPP+Y9R/JR3h7vzdZZNMY2m3RVBhqj6jwobLY1r3rJIXmQX/Tp4fx3FAw89FYJB
         L17Q==
X-Gm-Message-State: APjAAAUcKRY++WksnoOCV2tqqtwf8tPHjOZikE3Hx/AX6/NHq3Dbx5XI
        eDHFk+LNINLUD/Igqb+OxngMDg==
X-Google-Smtp-Source: APXvYqxaTHEpFFiQZup6XQn2PbZcySWoeRwB/NVlpJYjByDpkiCOma6cBuOWzanuc/eKJ88gdvErxA==
X-Received: by 2002:a63:a804:: with SMTP id o4mr4361140pgf.401.1572507106443;
        Thu, 31 Oct 2019 00:31:46 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li336-180.members.linode.com. [96.126.103.180])
        by smtp.gmail.com with ESMTPSA id g38sm2300333pgb.27.2019.10.31.00.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 00:31:43 -0700 (PDT)
Date:   Thu, 31 Oct 2019 15:31:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
Message-ID: <20191031073136.GC21153@leoy-ThinkPad-X240s>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
 <20191030141950.GB21153@leoy-ThinkPad-X240s>
 <20191030162325.GT4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030162325.GT4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ + Will, Mark ]

On Wed, Oct 30, 2019 at 05:23:25PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 30, 2019 at 10:19:50PM +0800, Leo Yan wrote:
> > On Wed, Oct 30, 2019 at 01:46:59PM +0100, Peter Zijlstra wrote:
> > > On Wed, Oct 30, 2019 at 06:47:47PM +0800, Leo Yan wrote:
> 
> > > Anyway, the below argument doesn't care much, it works for NOP/JMP just
> > > fine.
> > 
> > We can support NOP/JMP case as the first step, but later should can
> > extend to support other transitions.
> 
> Since all instructions (with the possible exception of RET) are
> unconditional branch instructions: NOP, JMP, CALL. It makes no read
> difference to the argument below.
> 
> ( I'm thinking RET might be special in that it reads the return address
> from the stack and therefore must emit the whole IP into the stream, as
> we cannot know the stack state )

To be honest, I don't have knowledge what's the exactly format for 'ret'
in CoreSight trace; so would like to leave this to Mike.

Since Mike has confirmed that Arm CoreSight also needs the accurate
code for decoding branch/call instructions, it's no doubt that we need
to implement the same mechanism at here to update DSO for the accurate
code flow.  So the question is how to do this on Arm/Arm64 :)

Before move farward, I'd like to step back to describe clearly what's
current problem on Arm64 and check one question for jump label:

I checked the kernel code, both kprobe and ftrace both uses
stop_machine() to alter instructions, since all CPUs run into stop
machine's synchronization, there have no race condition between
instructions transition and CPUs execte the altered instruction; thus
it's safe for kprobe and ftrace to use perf event PERF_TEXT_POKE_UPDATE
to notify instruction transition and can allow us to read out 'correct'
instruction for decoder.

But for jump label, it doesn't use the stop_machine() and perf event
PERF_TEXT_POKE_UPDATE will introduce race condition as below (Let's see
the example for transition from nop to branch):

              CPU0                                      CPU1
  NOP instruction
   `-> static_key_enable()
        `-> aarch64_insn_patch_text_nosync()
             `-> perf event PERF_TEXT_POKE_UPDATE
                                                     -> Execute nop
                                                        instruction
             `-> aarch64_insn_write()
             `-> __flush_icache_range()

Since x86 platform have INT3 as a mediate state, it can avoid the
race condition between CPU0 (who is do transition) and other CPUs (who
is possible to execute nop/branch).

> > > > we need to update dso cache for the
> > > > 'PERF_TEXT_POKE_UPDATE_PREV' event; if detect the instruction is
> > > > changed from branch to nop, we need to update dso cache for
> > > > 'PERF_TEXT_POKE_UPDATE_POST' event.  The main idea is to ensure the
> > > > branch instructions can be safely contained in the dso file and any
> > > > branch samples can read out correct branch instruction.
> > > > 
> > > > Could you confirm this is the same with your understanding?  Or I miss
> > > > anything?  I personally even think the pair events can be used for
> > > > different arches (e.g. the solution can be reused on Arm64/x86, etc).
> > > 
> > > So the problem we have with PT is that it is a bit-stream of
> > > branch taken/not-taken decisions. In order to decode that we need to
> > > have an accurate view of the unconditional code flow.
> > > 
> > > Both NOP/JMP are unconditional and we need to exactly know which of the
> > > two was encountered.
> > 
> > If I understand correctly, PT decoder needs to read out instructions
> > from dso and decide the instruction type (NOP or JMP), and finally
> > generate the accurate code flow.
> > 
> > So PT decoder relies on (cached) DSO for decoding.  As I know, this
> > might be different from Arm CS, since Arm CS decoder is merely
> > generate packets and it doesn't need to rely on DSO for decoding.
> 
> Given a start point (from a start or sync packet) we scan the
> instruction stream forward until the first conditional branch
> instruction. Then we consume the next available branch decision bit to
> know where to continue.
> 
> So yes, we need to have a correct text image available for this to work.
> 
> > > With your scheme, I don't see how we can ever actually know that. When
> > > we get the PRE event, all we really know is that we're going to change
> > > a specific instruction into another. And at the POST event we know it
> > > has been done. But in between these two events, we have no clue which of
> > > the two instructions is live on which CPU (two CPUs might in fact have a
> > > different live instruction at the same time).
> > >
> > > This means we _cannot_ unambiguously decode a taken/not-taken decision
> > > stream.
> > > 
> > > Does CS have this same problem, and how would the PRE/POST events help
> > > with that?
> > 
> > My purpose is to use PRE event and POST event to update cached DSO,
> > thus perf tool can read out 'correct' instructions and fill them into
> > instruction/branch samples.
> 
> The thing is, as I argued, the instruction state between PRE and POST is
> ambiguous. This makes it impossible to decode the branch decision
> stream.
> 
> Suppose CPU0 emits the PRE event at T1 and the POST event at T5, but we
> have CPU1 covering the instruction at T3.
> 
> How do you decide where CPU1 goes and what the next conditional branch
> is?

Sorry for my not well thought.

I agree that T3 is an uncertain state with below flow:

      CPU0                                             CPU1
  perf event PERF_TEXT_POKE_UPDATE_PRE   -> T1

    Int3 / NOP                                       -> T3

    Int3 / branch                                    -> T3'

  perf event PERF_TEXT_POKE_UPDATE_POST  -> T5

Except if the trace has extra info and can use old/new instructions
combination for analysis, otherwise PRE/POST pair events aren't helpful
for resolve this issue (if trace decoder can do this, then the change in
kernel will be much simpler).

Below are two potential options we can use on Arm64 platform:

- Change to use stop_machine() for jump label; this might introduce
  performance issue if jump label is altered frequently.

  To mitigate the impaction, we can only use stop_machine() when
  detect the perf events are enabled, otherwise will rollback to use
  the old code path.

- We can use breakpoint to emulate the similiar flow with x86's int3,
  thus we can dismiss the race condition between one CPU alters
  instruction and other CPUs run into the alternative instruction.

@Will, @Mark, could you help review this?  Appreciate any comments
and suggestions.  And please let me know if you want to consolidate
related works with your side (or as you know if there have ongoing
discussion or someone works on this).

Thanks,
Leo Yan
