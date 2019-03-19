Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333B7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0089E2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552988226;
	bh=BiODvzMs8O8n08Nw0m13r7zUmXKt+W01znHhpDxnpEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K1zFO8WW/Si70uXPSCF8Q7oahAKcOKB5aLGxXw/oIFcGUU0TOFZMyNAO43k65LnIL
	 QVCdm6ELCm0z5X4+PyT3cKXsysrX/ndfKDaQwb0DqU5S1SnZJp0p5SkZ41xaZahFDn
	 Md7xdmRSqs+jKqT+laKCL3OnnV1u9zssKWGmqGW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfCSJhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:37:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46556 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSJhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:37:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id z26so16427323lja.13;
        Tue, 19 Mar 2019 02:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ylIvRVXZOaIWwTVKoKyUk9DgIL38Ed+J86i0LWjU5FE=;
        b=hK6HqJHZ8THI+XZer2Q41BHwcPIYSjvQ3KuwI1YvdL3qpHEZMC0Llz/ruZwlxsIt8i
         hY4nNuZzSbgwxLgqpycgAfRWFkL4H8HxapM/7g9isWh4ICFaFdJhlhyJM6cFph8Gm/3o
         Q/y7EiFMd2FXQScF71Du2fm/wbvRDeo5weVwIHfW6T7mL6n/AFGs6qQBjp60P1j1M/rC
         iUhczGO/cnBobYm4OraHBCOmRZ12o9etpuWR/k6TZ/gaUJqzVmq+XwVjmiKiypsxlo1s
         nH5rhr4S4vZUVR0iEY2qVX+P09HpHu4WLB/Wxh2QpJEuriLcy88Qq6GuS+8E5Lsnn1zq
         spUw==
X-Gm-Message-State: APjAAAUbTr7uKM2X0FQ/kL6Kp9GmArQ94tUV4LkrfawMmdNHbPWTwsqo
        hCj/DlGgMf5TGPh2RAOonWg=
X-Google-Smtp-Source: APXvYqyro22GyYDv5+Pd4YwgdjyiAeA7AQWRcFUPlkQgQMlZ9Oudl0o4rUqRGJmVrobRg33Q+IZy7g==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr13456256ljg.1.1552988222259;
        Tue, 19 Mar 2019 02:37:02 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q22sm2669086ljc.59.2019.03.19.02.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 02:37:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1h6BB2-0004k4-Mw; Tue, 19 Mar 2019 10:36:56 +0100
Date:   Tue, 19 Mar 2019 10:36:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     George McCollister <george.mccollister@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add additional NovaTech products
Message-ID: <20190319093656.GH6124@localhost>
References: <20190305220503.8022-1-george.mccollister@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305220503.8022-1-george.mccollister@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 04:05:03PM -0600, George McCollister wrote:
> Add PIDs for the NovaTech OrionLX+ and Orion I/O so they can be
> automatically detected.
> 
> Signed-off-by: George McCollister <george.mccollister@gmail.com>

Applied, thanks.

Johan
