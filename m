Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BBDC2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7B821D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="Fj90E7Xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgABTWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:22:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36309 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgABTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:22:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so32491027qkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=79zMLHtVC8xs2RALirflwpQq5tYiUVAhO2rVoiGE7aQ=;
        b=Fj90E7Xrg7UIIOshQt+/7b8UWs93Fl4Ty9jh3sOXmr3Njz5CMuipkdCaDqdycn4S2V
         grswIkrOntOtjjUwGZuOJlp2QdJyGMANs2uKmgqrfUGD8CROlm5neqQeV7USsAHio35Q
         zfoVVJTUX1crQojZHf/r9EyfdpHGY9WPByQ1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=79zMLHtVC8xs2RALirflwpQq5tYiUVAhO2rVoiGE7aQ=;
        b=FqTfkEAmTEHq4ZzKsMsIxn43o7ObDTmp5qurpcF1z9PRHU3GWwojKRUrsgRt3dAeyd
         EEgCwXjywzPHmFPaG2Kxn51aYgplfXs2xNbwm4XkDeo78Fsz+GJFf9qbVPv4wr3XXFqm
         FP7nqxY1iA/1itdG0FCc5o54cAdx1URve2zQ48DAR9l1TDOWv4EDRnYK7n49MTF8Uvyu
         3yrnKw7X+Q1W9hpYSdzPEn1KoKzsm+CtKOP+xxagFldzTRWPLnv+L5q8Pw0KwuUlemAh
         Wa2jYQdTOv/Rk4oLzdjP506e7CxKYySWxEMOCVnNO2VcQ59KAb5us1b8qt2U7OW841Bo
         mbFg==
X-Gm-Message-State: APjAAAVyF8qW2VGv3DTFVCfehSbn5cy9cSVyykpZS8hoMtFPILRjPACg
        5oNPxG3ZYj6hsQn8Px/OUrJIDRS82CY=
X-Google-Smtp-Source: APXvYqyN43NJDeYwEB+a6cY1qrCyvp6ADY9/wy2AlNTQvPM45PU9X08mtxGnArWV5fVF4LtNRzCFcg==
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr67568449qko.37.1577992973148;
        Thu, 02 Jan 2020 11:22:53 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id r66sm15305288qkd.125.2020.01.02.11.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 11:22:50 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 2 Jan 2020 14:22:47 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     linux-kernel@vger.kernel.org
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [perf] perf_event_open() sometimes returning 0
In-Reply-To: <alpine.DEB.2.21.2001021349390.11372@macbook-air>
Message-ID: <alpine.DEB.2.21.2001021418590.11372@macbook-air>
References: <alpine.DEB.2.21.2001021349390.11372@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020, Vince Weaver wrote:

> so I was tracking down some odd behavior in the perf_fuzzer which turns 
> out to be because perf_even_open() sometimes returns 0 (indicating a file 
> descriptor of 0) even though as far as I can tell stdin is still open.

error is triggered if aux_sample_size has non-zero value.

seems to be this line in kernel/events/core.c:


 if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
                goto err_locked;


(note, err is never set)


Vince

