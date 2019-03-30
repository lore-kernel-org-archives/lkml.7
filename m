Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6407FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AF02184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKQIKVWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfC3HEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:04:24 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40187 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfC3HEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:04:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id p64so1487100ywg.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=k0mfWv6Y85DCt3e1yhG3SpLTvTbMak4HIYZSMqI97I4=;
        b=aKQIKVWnCEt5vQa9HaZ9vRMrWTCJrx9Urrt/s/n2/aqKcoq4CoB4rNOAsh5YRzH5P/
         ED+x8VzDeoS6HpIyo7jaV7arqRV67Kwx/cy4RgoQKWHiAKorgBd50iJpCTh17VYuL3wf
         AnVEmlaOdi5s/ePMJhtL2JgkZCeuyQKHlZQnvdWLWlHyb0sop/U7doDaQZMM6SVCTDhs
         jTm8OkIiROAK0e2qkYorSSDHmDiO0YQlqaOrFCYHKaiiwY66HGELH2LEs+MR6p9vU4JI
         eFx/TE/GuCnLIxs9NcXu8NO/LDnUr+Kkq/UOwiTLPIjyAWr1NsJXNjlnnUdz0kJgHeRu
         rg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=k0mfWv6Y85DCt3e1yhG3SpLTvTbMak4HIYZSMqI97I4=;
        b=YT6Oec1AnjjmZzTXQ9IRTpR4ICP25ND/jJpUi4HNX2SsIMI5W8641BihdWJuW70yjm
         Jh4cDyIdwzSXDAJhn4fzcN+ZuHfOaPgpg/oUWrqih8kWlQKF1bONQ44hME6LDwsxG6Jf
         VanrKsSJK4dD8MCYiHUq6up3/QZlXlimiTP5xYFprPQUnGwbqKEv7IlYmL1HSiPInoUP
         CTwvaoZTqaaO1bnYmw1RM+5tsBlXOaiTOY1yIiH0pG8EV7Hic/BNk3OylH7va7BntiOi
         r0z+0hJz1lnYvrxNGS4f+77ZV9hijkZE44lyxHpGYQUj4hyH7bl7S2BKtsE0ItS8wOxt
         rY0Q==
X-Gm-Message-State: APjAAAW0qwXWXaxMMRM/bjCskC2Mb9xd3zs2rBQ/L/X6fsGdG9pS8rC5
        Nw16mjRVIVXlNw5JhPb950baALcP9WQEYm0JgL8=
X-Google-Smtp-Source: APXvYqxbmT7bvdBeACTRdG9YwnUFmRi5aEB8FKCBPaHgPHDpgQlc0DYqoP3A26sqflHexCoBmZYBFqP6jcLQWLb+4wI=
X-Received: by 2002:a81:9295:: with SMTP id j143mr45406579ywg.24.1553929462967;
 Sat, 30 Mar 2019 00:04:22 -0700 (PDT)
MIME-Version: 1.0
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Date:   Sat, 30 Mar 2019 15:05:11 +0800
Message-ID: <CABXRUiSUzuf+Ki1Pj9oUkgZC0ELkA4N1aZpwBrZ7Gu3nyGwPMQ@mail.gmail.com>
Subject: a kernel address leak via copy_to_user in drivers/tty/rocket.c
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, recently I found that there is a kernel address leaks to user
space via copy_to_user in
drivers/tty/rocket.c:1287 (linux-5.0.5)
static int rp_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned
long arg) {
  ...
  case RCKP_GET_STRUCT:
      if (copy_to_user(argp, info, sizeof(struct r_port))
  ...
}
The `info` is a struct r_port. and the field `r_port.port.ops` is an
constant pointer,
and it points to a constant object `rocket_port_ops` during the initialization.
(function init_r_port) (drivers/tty/rocket.c:633)

patch suggestion:
set the pointer field to null before the copy to user call.
