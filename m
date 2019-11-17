Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B32C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D01B2067D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="osuOmhvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKWSPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:15:00 -0500
Received: from sender4-pp-o97.zoho.com ([136.143.188.97]:25725 "EHLO
        sender4-pp-o97.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKWSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:15:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574532890; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FJJjui7nV/ZNN1Rx8QvVjgMhJk4ZoeEJov7UXfqcdi0QrfZ4cYxG5o+ljylp3sxZ3JpryTVplgX/s5fRhs5KlYtm0hwfooh/1dYqHp9UPut2c0TEeR/1b7DRBWt6kKp5Wn+HGAMiv98ouRJTaLQu5i7EJdS3WyXudu+XxYQqRCk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574532890; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=H94x1tfJHQJNFBM0ErsvL0Uudwa/ZEgpUH9VtK3qs9s=; 
        b=DgsarA3B5bEEcVfEOcoZgbk5WUbmVNE31CCOAgw0B0ZTAPEoV+aki/YkMqsoiFnmxQguNXdJG8amai8mt8SH++YzkOEe2NsRiukwmkrlMGDi2ml+mO+zTm/xGLr/hAUBbuRtKl2h0ftFCpqOJXKn/Kbenmn/BvkpP86pOtxUwDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=m3TfuYGY062VoEhYG7TyUWNj6+/aobs7c2tUYh2qAuwLC866iT3BQN3+Fo5ovyaVYojvu/4bb85p
    EFxyZu65T67KSnSz4dbb3a7enM8zPG+0HJ5W4NtzJws92p2K47iS  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574532890;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=H94x1tfJHQJNFBM0ErsvL0Uudwa/ZEgpUH9VtK3qs9s=;
        b=osuOmhvSAwafp/ZI9m0Y4Iwmkp665XB7x85IQgLbYuSpoUPUeZyn2WIuzJqNmC8f
        N6bOsEfv6tbgtehR+IFOZ3QXgE7YD6YbkRdOQ0ZYW/IQnH1HpQFJJrz/qrB6d6OwfM3
        TwuHbLoUAYgh3QZ8T3yoZjn9A+WfWwqH5SWlOsnQ=
Received: from localhost.localdomain (171.221.112.247 [171.221.112.247]) by mx.zohomail.com
        with SMTPS id 1574532888652420.3861808291093; Sat, 23 Nov 2019 10:14:48 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, paulburton@kernel.org, mark.rutland@arm.com,
        linus.walleij@linaro.org, paul@crapouillou.net
Subject: Fix bugs in X1000/X1500 and add X1830 pinctrl driver v4.
Date:   Mon, 18 Nov 2019 02:14:05 +0800
Message-Id: <1574014449-112057-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3->v4:
1.Use local variables to streamline code.
2.Prevents processors older than X1830 from being
  configured in HiZ mode.


