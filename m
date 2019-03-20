Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407AB218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="QtqtAKOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfCTUyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:54:14 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34388 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfCTUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:54:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id n6so15029605qkf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=nmNX47cZo5NsoZSR0o/fEP6tWKwZHsvTNVNPkN8GvRQ=;
        b=QtqtAKOChAatdnuxZ5CFDvsOCxbE7YzukOhiborUrLxxqzg+Wiyzx0ZSZKjL2WJpQ+
         75MN3aA+lW+uUuvvW1Z0GdRnrru7NmLEDvnFU2p4oTICZA299nnWvGwnGRYljPZbq2lP
         oEKIjFbQYPG5DfDVXiROAG5UbwGU0jUOy2WyqWwt8leJZwdJ0NlmQoDxOxv1rTKgYmiD
         364cXuK3riYJlJcyEVD5TCJyealvfLJvl0PDovqr8n7G+HFtu4RI5LkxnHm/XMp1bMsi
         j//jYVzyeoBpRHOJjgibyJXiVs/4rqpn8QW/OKIPxoPvmmYHwVP/pfFLDeGhlFlaeDwz
         KbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=nmNX47cZo5NsoZSR0o/fEP6tWKwZHsvTNVNPkN8GvRQ=;
        b=q8JN+13N68zsC/Gw41voh55ahlR1UdUVrD66x4Xrq9ag11VJnd0Ykd+yQNthKA1QFT
         aMIUaDcdFd4PDTuLY5KB4sV0K/6U81EdOz+o4BMFJzi+S0mnUWG/Dcz0zPiJpKge9W6N
         qsfulWf6KbOw1/V6OcWLfCoSQwSv++a8RRJhVfLCbwrplX5e5IBTxwjjwoGVPGL+ZHyu
         gSIXrDl0jC9BKeaSa5bi2nJAjAVlUhY1PzlDzdRNGYVNxLF4Wjx//Ftoig3TjKlMdrl/
         kgqJgYE8OgmRJudwYPNDOiUdadAsAEt+3Rp2iSWZ1giBb05MUtAYmQcoA0lKCXDn55+U
         GdnA==
X-Gm-Message-State: APjAAAX2szbr2RtIHKTa69gIpKkBGATg4S4WGzoFubuplzRCXtjKZx99
        rsTY9+fl0yIXN37lAncbwkciivhYjzQ=
X-Google-Smtp-Source: APXvYqzxxYig4EYY1geZdbE29ov9X5NuDVG2aVDAsPMRoUtM2TDjFg1HsouY+O8Q//X/398k5F82YA==
X-Received: by 2002:a05:620a:15c4:: with SMTP id o4mr8572933qkm.175.1553115253518;
        Wed, 20 Mar 2019 13:54:13 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p46sm2340818qtc.41.2019.03.20.13.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 13:54:13 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:54:09 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: Re: [PATCH bpf-next v1 1/7] tools: bpftool: fix infinite loop
Message-ID: <20190320135409.7b67c208@cakuba.netronome.com>
In-Reply-To: <20190320173332.18105-1-alban@kinvolk.io>
References: <20190320173332.18105-1-alban@kinvolk.io>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 18:33:26 +0100, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> Symptoms: when forgetting to type the keyword 'type' in front of 'hash':
> $ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
> (infinite loop, taking all the CPU)
> ^C
> 

Please add:

Fixes: 0b592b5a01be ("tools: bpftool: add map create command")

here.  And submit this one for the bpf tree.

> Signed-off-by: Alban Crequy <alban@kinvolk.io>

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index e0c650d91784..994a7e0d16fb 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1151,6 +1151,9 @@ static int do_create(int argc, char **argv)
>  				return -1;
>  			}
>  			NEXT_ARG();
> +		} else {
> +			p_err("unknown arg %s", *argv);
> +			return -1;
>  		}
>  	}
>  
