Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28A1C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843D5206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtbWHL40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfCHTr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:47:29 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38874 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHTr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:47:29 -0500
Received: by mail-qt1-f196.google.com with SMTP id s1so22561771qte.5;
        Fri, 08 Mar 2019 11:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n50Te2F9BCT1+ySXIcH97yZ8M0jGzX8gA1eTakIvfyo=;
        b=XtbWHL40iVGQbTEzx0pjWOQ5rP3B6ciEx6wqCnmexY5Wvke+UC5amGqGEeGeqNJIKH
         ENZUa+EPvrOsbaC8rDf/fA7RcFSgTLybN3JZ3A/QU/HM0SQv/aQnk2jumkejR2HmvbOI
         oZze48eeWmJCJL7tRt2yC72qK47N1X74P7dYc9Ptzt5k4bzkl46EJBRHpxA8mZphVdzO
         iHDm/ApLRLzrWWyFrwZPfw8Wrm4RQdIQ5uTaMRvozbMrs5MMaRoOElCSyD87D4gOj4WV
         bH6KwYuaT9c+IYkbd0Jgg/euP2QfxMibqXMvcfvXofXGzvzLced3rvRo+QVBz+SJH+XE
         x+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n50Te2F9BCT1+ySXIcH97yZ8M0jGzX8gA1eTakIvfyo=;
        b=JAewslVgHjEdTw3FXr0OgkcLRmBUdUK3xfCaB853YjpDzDxc26kIPFiMiRgTB92Lvs
         Mtn2CAiGHUbWDAXQ/EzXZkT3g5d5nHpv1PhWvUfUqJAH6bfPTObrOBTupmZ2YImd9QjN
         uPQUxA78lxFBzDD3VggGHQwzMjguD6AkyIZd5QDAE97Te0bb50T4nAXNfL6PYG3hkp6e
         9mZ6LZULoJcYNw2q6B3ED/LABN/NJqvj8YjUnrmRCXJCb86rYMVXyGoGxRvV1mzFLXF+
         +owUvXM+n/5IQCuOYBSjyOhXLBA7pqfmtuBA87WW5pJYgKUThNgOG5d1wCwm6mbFyz9e
         3I+A==
X-Gm-Message-State: APjAAAW+n1LlHD/YICyvD8O2WziJfFyk1fURMLVd5SS8GeJe0TtPl3QD
        i/rqHNE4sNp6sXN9CKlyA/Y=
X-Google-Smtp-Source: APXvYqzNJI/T6vdYrhaPfQeQqnPlkuud5M3wodnQJPzyPFKqstmqvUaLwfsJ8vVy/YakOuJURzRQtQ==
X-Received: by 2002:a0c:c96e:: with SMTP id v43mr16659229qvj.200.1552074447876;
        Fri, 08 Mar 2019 11:47:27 -0800 (PST)
Received: from crypto.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n27sm2393038qtf.11.2019.03.08.11.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 11:47:27 -0800 (PST)
From:   Anderson Reis <andersonreisrosa@gmail.com>
X-Google-Original-From: Anderson Reis <anderson.reis.rosa@usp.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, matt.ranostay@konsulko.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <anderson.reis.rosa@usp.com>
Subject: [PATCH v2 0/4] iio:potentiostat:lmp91000: Adjust codestyle, and minor cleanup changes
Date:   Fri,  8 Mar 2019 16:46:51 -0300
Message-Id: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We solved some checkpath.el CHECKs and WARNINGs. We also inverted the arms of
an if statement, in order to make the code smaller as the else statement was
supressed. We also changed a dev_err message as requested


Anderson Reis (3):
  iio:potentiostat:lmp91000: reduce line width and remove blank line
  iio:potentiostat:lmp91000: invert if statement
  iio:potentiostat:lmp91000: change dev_err message

Lucas Oshiro (1):
  iio:potentiostat:lmp91000: remove unnecessary parentheses

 drivers/iio/potentiostat/lmp91000.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

-- 
2.20.1

