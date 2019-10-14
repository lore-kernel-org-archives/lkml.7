Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754CBECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8E1217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iSVi5Syy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbfJNOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:51:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41120 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:51:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id v52so25777374qtb.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k8cAZuPl6XV2WDQXDBabAxPwA0HPU6DlRuaDvX64hUE=;
        b=iSVi5SyyXkhPFLimDA9bP2kUxsggWZd6tYNgic0OT+oV1mg8uNvVVig1qIPxE3J7w2
         J3FhOxzTZpudzWnNgrkuDsEVcgwWQFOIUq/6RoTHaeroh6d9xjo8rXLYcSzqb2eOP/J8
         6Sild2t4N9JgE0F0OHSRZxMi2ICTFNF96+lOHtDqhTGWTyedkYvJWnUPSlwUye+Zzxwh
         /01FiE2vizs9yjyLrjyqolAxquIXoBpHprHQhIAU2Y71F9QUPPYh8eYUgAUAfgJq7Va6
         skAFdm487H7g1SQm8aGsqi+mY+2IPqEMw9elAgHl9o1YwagV78PqJVOkeFjTRYalLHwh
         /toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k8cAZuPl6XV2WDQXDBabAxPwA0HPU6DlRuaDvX64hUE=;
        b=M7LWN28N91qjZjzp9lOgUblY8C8AZdfPYmJbGgL6sJtEUI5YbCMfA8kQxDz03MFzE5
         jUTKo55Vf6lq+bqaSDh0SbWpe3PR19jhHXINByOr32ZxymGPKCcRPz9ynljNqi8zwSUg
         FPFyAbxyGVtvAmR7XWXKM/Mk7skHzzj3iMFIazUe1lge4FRwXjhAZnd8H6azcL7C9OgT
         Tw082MSwAJtaQLuCYAOiSGjLeB/2tmWjNBskrU1dCQHlVAP/mUXzwG/xiZinbEsSIF3v
         4TNzxu9Ww+0P1XilahLMdN7r/xGqAnS9sIrwLe0Rp5du/hjRDnnTjeCM7Rv/wvWGIadt
         uIYg==
X-Gm-Message-State: APjAAAUnirlPMnV65TdJRfHUrKR4jrbv20hVIDfQ9G6GxfWCYMdhC9vv
        Xv8SCzkx8yilOsV1CXuhPp3xuA==
X-Google-Smtp-Source: APXvYqwE3oTkh5m6IRNf9shvJzMEDIrzoKOeL0YvN1NLoZs9oq4KbIQH4AFxlqEvf59XpXbCInkklw==
X-Received: by 2002:ac8:7152:: with SMTP id h18mr33667358qtp.377.1571064687562;
        Mon, 14 Oct 2019 07:51:27 -0700 (PDT)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id g19sm11529214qtb.2.2019.10.14.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:51:26 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:51:25 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
Subject: Re: [PATCH v6 03/17] arm64: hibernate: check pgd table allocation
Message-ID: <20191014145125.ahemooviyznqgpdh@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-4-pasha.tatashin@soleen.com>
 <b5f965b5-bbd6-9e53-c085-d1a0c0dceca7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f965b5-bbd6-9e53-c085-d1a0c0dceca7@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for splitting [0] into two ... but this fix depends on the previous patch - which
> isn't an issue that anyone can hit, and doesn't match Greg's 'stable-kernel-rules'.
> 
> Please separate out this patch - and post it on its own as a stand-alone fix that can be
> sent to the stable trees.
> 
> 
> Mixing fixes with other patches leads to problems like this. It isn't possible to pick
> this fix independently of the cleanup in the previous patch.

Thank you, I sent it out as a separate fix.
