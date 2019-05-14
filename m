Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC14C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D435B2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBRvZK07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfENKOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:14:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45065 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENKOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:14:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id n22so11374284lfe.12;
        Tue, 14 May 2019 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YIZ3kgLRbbPlHjkQaU8GGW+xZ44MSvuVReE59qUFDXA=;
        b=JBRvZK070+rHxRCffanCjbI2/OlhQwa/N8JN3+t1UbNb0ZYQimUxd33Mv2Zpx4KLZS
         GDvFb4JSDz7hP5h76UhrEJWz/qIWfJ0msGEEEZo0sUCN4IFw+2cvNTZDHm63L7wLQ/oJ
         giFTSAhwjDZcMxYwT4pB6APvKq4MLectAthKeM7idFVQcDynqel4xIZx7LJ5zLLvPIn+
         5u75SlFeZ/B7+FnH7tFI3p7MB+ytK8OkyfXYEa/seXEMHEptW4v4kb5EWLEwAJ+LUZ2l
         TuFrbnP2dv4sln+jpjciiwC/vTze9SdWsUqKFycqD5rrpoCa5MhGjRuT72aRMua/ztu2
         DaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YIZ3kgLRbbPlHjkQaU8GGW+xZ44MSvuVReE59qUFDXA=;
        b=aES5zRpUEmBEEGmAGdgYD3Xeuesp3L4KAy1fOvKK5uzPrbNmTazFJ4AFsBKiJCpcpE
         gdC19IO52rYyUP9FffYGjwafZUGYYI996NMwa5WVvRu1nQxxxkrCaryh3rHl+1wi2jFn
         O9H9lIMuwhOmKkW1b7w0RTj/ulsjruWan08bAdLe3f8SoOp+lOBONVjkVEc7F+bKIG0f
         MWWOuL1bEAtdPubd9v803aYDsy5ofxn56by8kGnsbErPXP8a9kKkUS4lPGklHY8QopOi
         4d1zqd9KYzNS50XCRSqGyX7uv95dexFt0rYRbS2VTUy71OETIBiBjuocrX/YaliLmNk5
         LzNg==
X-Gm-Message-State: APjAAAUkUAmy/P8x3HtQEXTXAISdW5lpXrYSIT4/Zc0vuSMfmSgUKdwk
        hLtNjSNA4a311L4qSHzgVhY=
X-Google-Smtp-Source: APXvYqzF+ksXffBErnYUSHAodm5Kp8IJ34xoA3xPxb207dmag1RJmhmD9ql2mAc2x/a2hhTvHKfRiQ==
X-Received: by 2002:ac2:51a9:: with SMTP id f9mr17085224lfk.56.1557828869654;
        Tue, 14 May 2019 03:14:29 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id v2sm3126359ljg.6.2019.05.14.03.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:14:28 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] tty: max310x: Simplify the code and fix a few bugs
Date:   Tue, 14 May 2019 13:14:08 +0300
Message-Id: <20190514101415.26754-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I started using this driver two years ago in kernek 4.4 and then in kernel
4.9. It didn't go well from the very beginning due to my platform
peculiarities: DW SPI core with hardware CS and relatively slow MIPS-based
SoC. This patchset is intended to fix some of the problems I found out
during the max310x driver utilization with max14830 device.

First of all it was discovered, that workqueue API isn't optimally used.
Work context isn't re-entrant by design, so the mutex used to guard the
TX-method is redundant. schedule_work() method is also created in a way
the work item is scheduled only if it isn't pending. Patch 1 concerns all
these fixes. Seeing the similar container_of(uart_port) is used three
times in the driver, the patch 2 introduces a macro to_max310x_port() to
get a pointer to corresponding struct max310x_one. This is the code
simplification and is going to be used in the following patches.

It was found out, that batch read and write methods used buffers allocated
on the kernel stack. Since they might be utilized by SPI controllers for
DMA it might be unsafe on some platforms. Patch 3 provides a dedicated
kmalloced buffers for this.

The baud-rate calculator function didn't work correct for all the possible
baud-rates requested within a pre-defined input reference frequency.
Instead an algo fully compliant with datasheet divisor formulae is
implemented in patch 4.

Patches 5 and 6 are created to fix some rs485 issues. Particularly the
rs485 mode is configured on the port startup if it's enabled. And seeing
the mode2 register provides a way to enable/disable the echo-suppression
in RS485 mode, it is used to implement the SER_RS485_RX_DURING_TX flag
support.

Finally it was discovered that in case if inbound hardware FIFO
experienced overflow, a lot of '\0' characters inserted into the
flip-buffer as a character of the RX-FIFO overrun. It isn't quite correct
since the overflow happened only after the last character had been
received. Patch 7 is dedicated to push only a single RX-FIFO overrun
character in this case.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>


Serge Semin (7):
  tty: max310x: Simplify tx-work item code
  tty: max310x: Introduce max310x_one port macro-wrapper
  tty: max310x: Don't pass stacked buffers to SPI
  tty: max310x: Fix invalid baudrate divisors calculator
  tty: max310x: Add rx-during-tx rs485 flag support
  tty: max310x: Optionally enable rs485 on startup
  tty: max310x: Split uart characters insertion loop

 drivers/tty/serial/max310x.c | 157 +++++++++++++++++++++--------------
 1 file changed, 95 insertions(+), 62 deletions(-)

-- 
2.21.0

