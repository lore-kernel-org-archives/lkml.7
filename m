Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0947EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0662183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553870447;
	bh=bsu/DwuniISwjehFV3/XIe2kf9xEiuVna1l+ar1MfLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AplI/bnyD3qYGdO3BrdbNwMZkhE5+3M7KIGuFxF1EiBoOwN0P5JCY4nBjTo51XbIP
	 qH9bex/07ccvNjsSwcqo8TEeQ2BMb6NjyIqLLt9Cc9mtiiyXBIjztco0SPqx6rfNrV
	 +VQ8n4kG2KwnB7S5GFffMEwM1VjBw85ygECF0Te8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfC2Okq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:40:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46226 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfC2Okq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:40:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so2152720ljk.13;
        Fri, 29 Mar 2019 07:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1m4WkVpmFHhVXK/F9iVemn6CgoVQb/s1ZYilF+ONsG8=;
        b=OramSq6HLTkhP1jNtCXO+ep7drMOjWIk6S2gTfSL/56nEDftlUecGrEY0eqEbiIzfI
         QR070LiUUNRiQVcQEd/+9y3RhAuW4LQPsxyqjxL6rs/wvRgTEY23wlnZ9x+F1GSvArHY
         vp7Xt1rifmz3Fr4KiA/LsK9dcs9PvLUIa5ZyEUDlPanexAS1/fBBffG8xVR4vlt4pcCa
         p49lgzYJVyBaKfcjGlm6Zg7O+RPF8y96QeROqdzCRDu5Zm4XLZFtH9B5UYiAHQ3d993w
         3wBPlfay5znmwGDNMAvw3LnnVRMTsi1btEqD1nvUcM7b2j88nmpeeWbhqC3ZGtbg250W
         zENQ==
X-Gm-Message-State: APjAAAWSj/wq55/9q7UpwILFk/ciBf0PfEfISKl23C9+SUr/cPaVK2RR
        txzw/43TJ9VxK5M++Y6R/Yw=
X-Google-Smtp-Source: APXvYqznOhAHGkfCteJ/wy6mJcBpnZ7qTAZCxkDL6bxpllKJciqvWUDIto9qoX87N6N8a/srkYmBIA==
X-Received: by 2002:a2e:9f05:: with SMTP id u5mr24703316ljk.183.1553870443958;
        Fri, 29 Mar 2019 07:40:43 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v21sm326558lfg.26.2019.03.29.07.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 07:40:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1h9sgd-0003I4-C1; Fri, 29 Mar 2019 15:40:51 +0100
Date:   Fri, 29 Mar 2019 15:40:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH V3 1/3] USB: serial: f81232: clear overrun flag
Message-ID: <20190329144051.GA12562@localhost>
References: <1553848122-1227-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553848122-1227-1-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 04:28:40PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The F81232 will report data and LSR with bulk like following format:
> bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
> 
> LSR will auto clear frame/parity/break error flag when reading by H/W,
> but overrrun will only cleared when reading LSR. So this patch add a
> worker to read LSR when overrun and flush the worker on close() &
> suspend().
> 
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---

What changed since v2? Please always make sure to include a changelog
here below the cut-off line.

Thanks,
Johan
