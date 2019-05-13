Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D10DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186AB208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udv5Xcub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfEMShK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:37:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46536 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfEMShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:37:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id z19so7027390qtz.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Lwm0xndERKze5NLWPFi0vMQykhnwWsHVVf9BHE4Jxqs=;
        b=Udv5Xcub0vIQOZ2CGJ6SGT2L9SEkWqnbFG+rD5OYamIVh7LLtT8/05jsgZk+BA5Gzs
         C9nSfgcYsb0iOBlr1Cqa5pbyJCO9ocWPWPA5jMunJqBq53lFgH0dttSpQ9J6ssBFsjo+
         gfYM5lF4q6MT3B/wcFe6YXoJTkfakIC+97SHPzU4mBkrWBHTacUUfNXEANSppIi4cQVA
         /dTUFb/HmKgBgrKxMPePJnzfSUPURtB4HH8R01KywOw8nD3mG+2HRhmBz4JLRNMHDWnf
         Jw7tTElBnxBjmlf5OGUAzo+jRxfo0rHk7CwuL8OCB8JEtmz6MlgYiXouG2ahwr65ZDsW
         kKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lwm0xndERKze5NLWPFi0vMQykhnwWsHVVf9BHE4Jxqs=;
        b=nj0iC8OMNLSSP6FGT7//0VBVdgATHU/SxWSSMaJE8fd9Aom3xaxx2jKjGy1zKgNbAq
         1QxLITf2yhfbpNevJTOues31Kbq0+Y+fdr+kKjln6D/pfMjrpcdWaHK4Kf7WKGcaz6hN
         /o2X4oal8O8fLjnqjBnWioWFeGLryxXYckn2FLnDTwMrKYnzREml1oAnrtGHK0mkwbc0
         40D+TOagM+s63CXoqD2v3/C1sL0bFFQUDKThLIG8yTa2Y5owL0H9an3vZV0bKY5ikpB+
         eNgSFRZbPVTZ41nu9282PqqAIzLVw8IGt5sJhJ2+S5tZm/Fz03Y/58rcIWIDupfLfaRQ
         6I1g==
X-Gm-Message-State: APjAAAVscBpQM/vPq6e5YJXz75guwg4HjtLX3VvwPEO1scBoKjxuuAZu
        hG7vA4mET/SSQ9Ol1YZK1io=
X-Google-Smtp-Source: APXvYqzNME5mvM1JMrkG4CCzscx+PGJG6goPaB5cZZPbaE/YHRUKhjhzWtu9wDo2hOBDbOmyLdAxTQ==
X-Received: by 2002:ac8:35fb:: with SMTP id l56mr25338337qtb.130.1557772628205;
        Mon, 13 May 2019 11:37:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id t124sm7255967qkh.29.2019.05.13.11.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 11:37:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72F75403AD; Mon, 13 May 2019 15:37:02 -0300 (-03)
Date:   Mon, 13 May 2019 15:37:02 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com
Subject: Re: [RESEND PATCH 1/3] perf, tools: Add support for recording and
 printing XMM registers
Message-ID: <20190513173716.GA8003@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506141926.13659-1-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 06, 2019 at 07:19:24AM -0700, kan.liang@linux.intel.com escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Icelake and later platforms support collecting XMM registers with PEBS
> event.
> Add support for perf script to dump them, and support
> for the register parser in perf record -I ... to configure them.
> For now they are just printed in hex, could potentially add
> other formats too.

So I noticed the sync warning about
tools/arch/x86/include/uapi/asm/perf_regs.h abd added a separate patch
for that, removing this part from this patch, applying it afterward.

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/arch/x86/include/uapi/asm/perf_regs.h | 23 ++++++++++++++++++-
>  tools/perf/arch/x86/include/perf_regs.h     | 25 +++++++++++++++++++--
>  tools/perf/arch/x86/util/perf_regs.c        | 16 +++++++++++++
>  tools/perf/util/perf_regs.h                 |  1 +
>  4 files changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
> index f3329cabce5c..ac67bbea10ca 100644
> --- a/tools/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
> @@ -27,8 +27,29 @@ enum perf_event_x86_regs {
>  	PERF_REG_X86_R13,
>  	PERF_REG_X86_R14,
>  	PERF_REG_X86_R15,
> -
> +	/* These are the limits for the GPRs. */
>  	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
>  	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
> +
> +	/* These all need two bits set because they are 128bit */
> +	PERF_REG_X86_XMM0  = 32,
> +	PERF_REG_X86_XMM1  = 34,
> +	PERF_REG_X86_XMM2  = 36,
> +	PERF_REG_X86_XMM3  = 38,
> +	PERF_REG_X86_XMM4  = 40,
> +	PERF_REG_X86_XMM5  = 42,
> +	PERF_REG_X86_XMM6  = 44,
> +	PERF_REG_X86_XMM7  = 46,
> +	PERF_REG_X86_XMM8  = 48,
> +	PERF_REG_X86_XMM9  = 50,
> +	PERF_REG_X86_XMM10 = 52,
> +	PERF_REG_X86_XMM11 = 54,
> +	PERF_REG_X86_XMM12 = 56,
> +	PERF_REG_X86_XMM13 = 58,
> +	PERF_REG_X86_XMM14 = 60,
> +	PERF_REG_X86_XMM15 = 62,
> +
> +	/* These include both GPRs and XMMX registers */
> +	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
>  };
>  #endif /* _ASM_X86_PERF_REGS_H */
> diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
> index 7f6d538f8a89..b7321337d100 100644
> --- a/tools/perf/arch/x86/include/perf_regs.h
> +++ b/tools/perf/arch/x86/include/perf_regs.h
> @@ -8,9 +8,9 @@
>  
>  void perf_regs_load(u64 *regs);
>  
> +#define PERF_REGS_MAX PERF_REG_X86_XMM_MAX
>  #ifndef HAVE_ARCH_X86_64_SUPPORT
>  #define PERF_REGS_MASK ((1ULL << PERF_REG_X86_32_MAX) - 1)
> -#define PERF_REGS_MAX PERF_REG_X86_32_MAX
>  #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_32
>  #else
>  #define REG_NOSUPPORT ((1ULL << PERF_REG_X86_DS) | \
> @@ -18,7 +18,6 @@ void perf_regs_load(u64 *regs);
>  		       (1ULL << PERF_REG_X86_FS) | \
>  		       (1ULL << PERF_REG_X86_GS))
>  #define PERF_REGS_MASK (((1ULL << PERF_REG_X86_64_MAX) - 1) & ~REG_NOSUPPORT)
> -#define PERF_REGS_MAX PERF_REG_X86_64_MAX
>  #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_64
>  #endif
>  #define PERF_REG_IP PERF_REG_X86_IP
> @@ -77,6 +76,28 @@ static inline const char *perf_reg_name(int id)
>  	case PERF_REG_X86_R15:
>  		return "R15";
>  #endif /* HAVE_ARCH_X86_64_SUPPORT */
> +
> +#define XMM(x) \
> +	case PERF_REG_X86_XMM ## x:	\
> +	case PERF_REG_X86_XMM ## x + 1:	\
> +		return "XMM" #x;
> +	XMM(0)
> +	XMM(1)
> +	XMM(2)
> +	XMM(3)
> +	XMM(4)
> +	XMM(5)
> +	XMM(6)
> +	XMM(7)
> +	XMM(8)
> +	XMM(9)
> +	XMM(10)
> +	XMM(11)
> +	XMM(12)
> +	XMM(13)
> +	XMM(14)
> +	XMM(15)
> +#undef XMM
>  	default:
>  		return NULL;
>  	}
> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
> index fead6b3b4206..71d7604dbf0b 100644
> --- a/tools/perf/arch/x86/util/perf_regs.c
> +++ b/tools/perf/arch/x86/util/perf_regs.c
> @@ -31,6 +31,22 @@ const struct sample_reg sample_reg_masks[] = {
>  	SMPL_REG(R14, PERF_REG_X86_R14),
>  	SMPL_REG(R15, PERF_REG_X86_R15),
>  #endif
> +	SMPL_REG2(XMM0, PERF_REG_X86_XMM0),
> +	SMPL_REG2(XMM1, PERF_REG_X86_XMM1),
> +	SMPL_REG2(XMM2, PERF_REG_X86_XMM2),
> +	SMPL_REG2(XMM3, PERF_REG_X86_XMM3),
> +	SMPL_REG2(XMM4, PERF_REG_X86_XMM4),
> +	SMPL_REG2(XMM5, PERF_REG_X86_XMM5),
> +	SMPL_REG2(XMM6, PERF_REG_X86_XMM6),
> +	SMPL_REG2(XMM7, PERF_REG_X86_XMM7),
> +	SMPL_REG2(XMM8, PERF_REG_X86_XMM8),
> +	SMPL_REG2(XMM9, PERF_REG_X86_XMM9),
> +	SMPL_REG2(XMM10, PERF_REG_X86_XMM10),
> +	SMPL_REG2(XMM11, PERF_REG_X86_XMM11),
> +	SMPL_REG2(XMM12, PERF_REG_X86_XMM12),
> +	SMPL_REG2(XMM13, PERF_REG_X86_XMM13),
> +	SMPL_REG2(XMM14, PERF_REG_X86_XMM14),
> +	SMPL_REG2(XMM15, PERF_REG_X86_XMM15),
>  	SMPL_REG_END
>  };
>  
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index c9319f8d17a6..1a15a4bfc28d 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -12,6 +12,7 @@ struct sample_reg {
>  	uint64_t mask;
>  };
>  #define SMPL_REG(n, b) { .name = #n, .mask = 1ULL << (b) }
> +#define SMPL_REG2(n, b) { .name = #n, .mask = 3ULL << (b) }
>  #define SMPL_REG_END { .name = NULL }
>  
>  extern const struct sample_reg sample_reg_masks[];
> -- 
> 2.17.1

-- 

- Arnaldo
