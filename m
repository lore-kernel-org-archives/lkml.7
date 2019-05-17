Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675D4C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 05:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B8120868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 05:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558069778;
	bh=bBZCUnv9zmc5bFfUSHti1ilOjQmJOMS80zodTsblb/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xPkuUEftNCSFLSPuAO6ug5vQGle8MjSPeZuDEdbhnG6irT0Cn219Eno44tq7w7Y9H
	 ssvVwbui7inSB+Z4smU4frZR9xRySd+FpyWkzlnR7yF6UcQ4AaLv7cKQbkhl2kIxNV
	 bu8F4K5OnPkQwBBF/bAEv03GV1uTnsBj2V2QlXP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfEQFJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 01:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfEQFJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 01:09:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03CE2083E;
        Fri, 17 May 2019 05:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558069776;
        bh=bBZCUnv9zmc5bFfUSHti1ilOjQmJOMS80zodTsblb/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ovpejk9YQViDPgT12OYLhYORK6l1D0nFYIkhIPp3oUjCO07IH6vkEE687HMtm+DQD
         jYKcOdHEYRT4yR0U6hIZjdyAQHNbDqAgj11l9r910odKXdZ1YYV9IMaO22fNflM62q
         9Lv8FehiJK1cdnoYe6We3zxLXT1X69xnW6Rcj2ks=
Date:   Fri, 17 May 2019 07:09:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: Linux 4.19 and GCC 9
Message-ID: <20190517050931.GB32367@kroah.com>
References: <CABWYdi06NUOWRLingNuybgZZsTZPjhmsOx-9oCGK94qZGYbzcw@mail.gmail.com>
 <CANiq72kvpiC-i53AXM-YsCUvWroHQemmqxsXjnB330ZEeHahUg@mail.gmail.com>
 <CABWYdi1zhTTaN-GSgH0DnPfz7p=SRw0wts5QVYYVtfvoiS0qnQ@mail.gmail.com>
 <CANiq72=fsL5m2_e+bNovFCHy3=YVf53EKGtGE_sWvsAD=ONHuQ@mail.gmail.com>
 <20190516225013.nvhwqi5tfwtby6qb@treble>
 <CABWYdi29E++jBw8boFZAiDZA7iT5NiJhnNmiHb-Rvd9+97hSVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi29E++jBw8boFZAiDZA7iT5NiJhnNmiHb-Rvd9+97hSVA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 08:14:25PM -0700, Ivan Babrou wrote:
> We are building the upstream kernel. There are a few patches, but
> nothing related to objtool.
> 
> Unless you mean mainline/stable by upstream, I haven't tried that. We
> stick to LTS.

Please work and all of these issues fixed up in Linus's tree and then I
will be glad to take the fixed into the stable releases.

thanks,

greg k-h
