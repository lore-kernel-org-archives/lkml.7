Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4A7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2D42089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTH63Odz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390957AbfIJG16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:27:58 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43019 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfIJG16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:27:58 -0400
Received: by mail-ot1-f46.google.com with SMTP id b2so16675122otq.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VjaVCvw7Es75Y87+TuInwO6wTJKd4OwHl3OoUN4X21M=;
        b=bTH63OdzbSyyfI3d3StOzzqmtb8AS1gEb5tEBg2YYe6kYDPWrrnohRw63Mv+AtEFPC
         eWNn1hnQMGWcD0GEOas6omOi5qouS2jNfDof/HckHf5JLRnmWPAwc388uCLFLM9dfg0Z
         llevmXvb0BEBOQlCbvsjl5BXxCyjHnTz48VK+mBewdU9j3H+/XnF3Bk09dYGl6HDXlef
         8u+z1a7c+bXliR0jZL30DYnFg1jPYy8B1rPnH+Dw/peMdjW576iR82HAgFKWA4Ns0bqL
         fh2Uau3mMqTelW1lljFchIkflqhhm+Ox+mJZopP4Y/OokuzULyG94TsqWJfseQeocDuj
         qhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VjaVCvw7Es75Y87+TuInwO6wTJKd4OwHl3OoUN4X21M=;
        b=sDWuVg9aOH3YOeGHsDPTMpQ7uykeYXjp+mZbYKRzNtB/A57DsueMkUWXEXtJgAET18
         4ALnSn/SYSyXOTj+yJDI2gp477kPjRdfgn/PR4kk6YxWi7Il73Ch3l30hzJKRzvVuDRd
         m2zp8Y+pUC/5b7GtBpIccAVcJoNz7eO2cYf8DQ8vOa3Zh1ILhNgPqTuo9HxcaKqc/L7b
         sPMIr3FfcnODNgOMugE9qgXae/bx7LnhnPiVaoc/fQBooC8R9TibUqWoVjGhHwrgGGdA
         sc0BWBSTxAkS3XmRDcD5FeBCi9lq2r1fAlBSBjr0Fhyq7MDzzS5/fnV24d6NuCGRSBge
         cmLQ==
X-Gm-Message-State: APjAAAWkVPyLV26kmAR0uYyaASp6OEAl660A6p+7JenBHuh7tJw81IfQ
        NKU4EJrSp9SnOu/PLbAcla2TSA==
X-Google-Smtp-Source: APXvYqyr/5ZSWwhxcxVoEpZMzkdjrJd95+TstKsGF8R+eAlLsTaGkBCm/1mlMp5lP9ovy746SFUEIQ==
X-Received: by 2002:a05:6830:184:: with SMTP id q4mr20085871ota.128.1568096876476;
        Mon, 09 Sep 2019 23:27:56 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e7sm3507003otp.64.2019.09.09.23.27.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 23:27:55 -0700 (PDT)
Date:   Mon, 9 Sep 2019 23:27:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Hugh Dickins <hughd@google.com>,
        kernel test robot <rong.a.chen@intel.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@01.org
Subject: Re: [vfs]  8bb3c61baf:  vm-scalability.median -23.7% regression
In-Reply-To: <20190909035653.GF1131@ZenIV.linux.org.uk>
Message-ID: <alpine.LSU.2.11.1909092301120.1267@eggly.anvils>
References: <20190903084122.GH15734@shao2-debian> <20190908214601.GC1131@ZenIV.linux.org.uk> <20190908234722.GE1131@ZenIV.linux.org.uk> <alpine.LSU.2.11.1909081953360.1134@eggly.anvils> <20190909035653.GF1131@ZenIV.linux.org.uk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2019, Al Viro wrote:
> 
> Anyway, see vfs.git#uncertain.shmem for what I've got with those folded in.
> Do you see any problems with that one?  That's the last 5 commits in there...

It's mostly fine, I've no problem with going your way instead of what
we had in mmotm; but I have seen some problems with it, and had been
intending to send you a fixup patch tonight (shmem_reconfigure() missing
unlock on error is the main problem, but there are other fixes needed).

But I'm growing tired. I've a feeling my "swap" of the mpols, instead
of immediate mpol_put(), was necessary to protect against a race with
shmem_get_sbmpol(), but I'm not clear-headed enough to trust myself on
that now.  And I've a mystery to solve, that shmem_reconfigure() gets
stuck into showing the wrong error message.

Tomorrow....

Oh, and my first attempt to build and boot that series over 5.3-rc5
wouldn't boot. Luckily there was a tell-tale "i915" in the stacktrace,
which reminded me of the drivers/gpu/drm/i915/gem/i915_gemfs.c fix
we discussed earlier in the cycle.  That is of course in linux-next
by now, but I wonder if your branch ought to contain a duplicate of
that fix, so that people with i915 doing bisections on 5.4-rc do not
fall into an unbootable hole between vfs and gpu merges.

Hugh
