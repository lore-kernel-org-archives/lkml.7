Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C97C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF27208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t69ygudK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfFNCuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:50:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41606 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFNCuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:50:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so457368pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 19:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Gt/SvG7yRtKmiEMzK1FJXFm1wfYI/ZfBKJY7bniNfw0=;
        b=t69ygudK4onHNkRftxENnMyaFh8fdIivsMy6XkYJOsbAxe53KcP8W2UWVupaCBHCqJ
         QWBO8UUP6jES+xjT2YwaT/YuqZKI92fYIfkmq425dclZ3WogxMlUeEvZviEmVBSU/w0n
         XFyvkrSI/QSLaDq+ZYD//QUBdFTf0J0uuk/fFfbRsDtDwo1D/YtHrepuNWAt6JxdgH9H
         /sroemESdRdVmnX2ImmUMmjBkYo9nbJ26Sfdes4gbBX+BGwbq0+TsCAA6RHlabYz6Ymh
         sbzzpOqyPTNXNhBu4aBps0QVvR6p2sn3sdrxaLIUpOMkR6r9dabYNjAgPmpRdEE+u1X7
         4CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Gt/SvG7yRtKmiEMzK1FJXFm1wfYI/ZfBKJY7bniNfw0=;
        b=psRXvSJi9gV71+P9QUivsTo8Ayar3HLxkt2i1VwMnf/9YwUi/DHF2+6ADAJRDSoczK
         A2gRcBQwd9vhrGqJFl2ca62H/UneAKl11YiipWmV3FzE9DvRyFvtgq4rwhGyvj0x3YYK
         tYk327zF+ZcIySkBUM0DNlI44Y8OA/EXHMHeCmryXCBZbhFCqgUW6PXRLu8VkyN9B6Gg
         lKjjN2o4/MMRAH+KfqO21H2BwCZCrk9hH5VH/8RS9ABO5jmMnzqBzotpJs4CuSr4LdS7
         dKlHcPwpA4HS7M5ejioTS15vToIAbTMNCqBOm8yjTMgp9tCYGDzlH/C8yqx7lqYyftun
         b9lg==
X-Gm-Message-State: APjAAAUo6VJuVbRBsJMXUNI3ESU/AH8DJgphfaUfAXLlopCsaGxFAg9q
        9B8QqtW1f7q0qJy1IjwToZU=
X-Google-Smtp-Source: APXvYqwUelCjdI/iBziKOHq8go5RgcYaj2UuHVhGitmfIpf2x4+NIcK1Gd/L6mXFGf10Am2WanFStA==
X-Received: by 2002:a63:ec42:: with SMTP id r2mr34433065pgj.262.1560480602071;
        Thu, 13 Jun 2019 19:50:02 -0700 (PDT)
Received: from localhost ([175.223.34.99])
        by smtp.gmail.com with ESMTPSA id a22sm1027270pfn.173.2019.06.13.19.50.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 19:50:01 -0700 (PDT)
Date:   Fri, 14 Jun 2019 11:49:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: nouveau: DRM: GPU lockup - switching to software fbcon
Message-ID: <20190614024957.GA9645@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.2.0-rc4-next-20190613

dmesg

 nouveau 0000:01:00.0: DRM: GPU lockup - switching to software fbcon
 nouveau 0000:01:00.0: fifo: SCHED_ERROR 0a [CTXSW_TIMEOUT]
 nouveau 0000:01:00.0: fifo: runlist 0: scheduled for recovery
 nouveau 0000:01:00.0: fifo: channel 5: killed
 nouveau 0000:01:00.0: fifo: engine 6: scheduled for recovery
 nouveau 0000:01:00.0: fifo: engine 0: scheduled for recovery
 nouveau 0000:01:00.0: firefox[476]: channel 5 killed!
 nouveau 0000:01:00.0: firefox[476]: failed to idle channel 5 [firefox[476]]

It lockups several times a day. Twice in just one hour today.
Can we fix this?

	-ss
