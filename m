Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9D7CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ECF21744
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hroZuIQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbfJ1Pc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:32:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35023 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730994AbfJ1Pc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:32:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id l3so4620231qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=K01MlbOPcqeaYhVIj4KrVUdXGySrNF3wqsQr/ouX7b0=;
        b=hroZuIQ/kLaov7AW148eGUTn1/nFPiDYcaajtH6eTf1Dur5xFiVRVAyOp482vUKlaJ
         MlwHEzEld8o/ujXiofVc/OEbYdtws5Fx1tLiZES4K5Zj69UWZJSnGfoMwcACWIR4pNyQ
         obNKNEsLq0yEbVJgLhzKOFjj5g28hgnsOzq/mjnylp7AnjSNPH1VGEsVS22RMvivefjx
         PGaY6yQVci35INvQZyiSscZOIHoRjbSqKgyAafe0CIiAbhtROeK/8+Q6ftAeA66xKUjr
         RMHR+jS5pLZt4Jih+eKmW15PQUemS/YrYZf7YeerxsYAIia5GkQtPlioWXKE7NERcoX7
         ZJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=K01MlbOPcqeaYhVIj4KrVUdXGySrNF3wqsQr/ouX7b0=;
        b=CxdIMBoUAZ/QfasR5EszBxoaoi0qOs1MQDHCPum4kQZW/z3wKaOIRdYnVb1+ma4GR0
         yKKpq3ofVvjAY90DaVxyo4IomipD7zmiyBhIULyYbxq7baZ0SGM5aYiyFaCsG5jFOt4D
         4fZxTyzGozcGelO9wQChFD8BQaDtSFixCC/Dxi6wm+he9UgLLo9mIfDINZrv6zIeGoa+
         QhtAYliFqacnKmZ2/2X3V6LAVAUAl6DGgmTmhJcMQBKZtzahlpuU5jKh+aNeXPGNDeeH
         o9W67BItoRHFB+4+VQH9ZD4Da57ENoaCQwKok9R7MrQWvIFngBvlVt0MHGLEu9pizqMf
         /yiw==
X-Gm-Message-State: APjAAAWlavquBeUOLq7ZrVYgxBME9ARrBBa6oWYqjf7iC7Fvkd7n5xQr
        TZI7hY3sMaGF/090RDeNcvw=
X-Google-Smtp-Source: APXvYqwtQnktlqPe5NSdXIY5QLs4zjauQbcdIt5qTHHiAlUgNUyzE7YfECvUiHlkldNe6ywG2LLxpw==
X-Received: by 2002:ac8:6d0b:: with SMTP id o11mr17554607qtt.253.1572276775728;
        Mon, 28 Oct 2019 08:32:55 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id w69sm2021498qkb.26.2019.10.28.08.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 08:32:55 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:32:50 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v4 0/2] Cleanup in rtl8712
Message-ID: <cover.1572276208.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup in rtl8712

Changes in v2:
 - Arranging conflict between author name and signed-off-by.
 - Remove unnecessary parentheses.
 - Change the driver name to rtl8712.

Changes in v3:
 - Change alignment of eth_type.
 - Change alignment of SN_EQUAL.
 - Remove commit of unneeded parentheses.

Changes in v4:
 - Fixing misplaced parentheses of previous version.


Cristiane Naves (2):
  staging: rtl8712: Fix Alignment of open parenthesis
  staging: rtl8712: Remove lines before a close brace

 drivers/staging/rtl8712/rtl8712_recv.c | 38 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

-- 
2.7.4

