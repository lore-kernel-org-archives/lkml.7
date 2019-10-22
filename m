Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDCACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A997621848
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="kCoZ78re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfJVUjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:39:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41385 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVUjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:39:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id x4so7888059lfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=38DGl3nPqfFsklGBVs5Uo+Om9XtfHJi1J5IGmBXqaaQ=;
        b=kCoZ78reb5yHDK3mP3U1hVx+acMo+Gm2oCNk0so70BBE5Zu9yFYMTmD1meyofr99B6
         7pOTJR0HG6ZmadunEQX6/eqUbkq+GJ6vzTIaElPCLKquVeiZuOzoqar9e0ns54+LLRzf
         o+EA6No8rCAuSgQqofIak/MXa/hHUu1ZyWytoX8i1tK3rAwJPQ1AACZjQUSuZAoBKDBz
         Fn108Ux5XS/ZBm9aekzkjgmK3JKafNy3v1l/LtT6uYAufRmrFB1bS766Fhu/Tx+tyJTt
         E8dzDXdk29zCjGsWBwYCdNQWzRimYS16nMNz77/CaXDrBMRbnFOcN9k7stEXzRFcgJkf
         BzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=38DGl3nPqfFsklGBVs5Uo+Om9XtfHJi1J5IGmBXqaaQ=;
        b=fdAWZLdhw5TRE8LqNLZ/hQyd3RrvbTtgDDHG5xwYvRP0Rrd1fYKzwYI/xSxIkji3Y4
         FbNvqhO02bEUPojqP2sLRTB163c9IbuKS0jV0WqsccZOzTWaB0A8kJkxVBkZkyeHriRy
         vGggb4EHOqGhgEouj6i5TsHJOVr+lmJXfrcE6HTq/ekpLzYhP12nYdUiggMg2Vy0O/ec
         XUWUyryP19TN0RarUtYU93d0nXX6+BJ9oLub9bWWD4QugQaS0SChTi5lDkRr1pivoway
         JtOaWnkegQq8jlDp+4L/k+Ti9N34/dc5d6HX5nHIGYMg4sJ/zW0tftzA8E/V8U7Qw807
         Qhdg==
X-Gm-Message-State: APjAAAUDEF5tQEefAaWP3zh8SJw70GUpd6UMV9HsI0Ft03gYaSQJXirC
        xaLK1j/K0m2RAU/i/bZAPWpIJg==
X-Google-Smtp-Source: APXvYqxHmFSxjbHN/b1h1ODrWfLW5wj2j/YE7RQvsafee8tng2tNAH6DWqton8e3D6rw5vjSX/CcJA==
X-Received: by 2002:a19:c214:: with SMTP id l20mr19391609lfc.123.1571776769018;
        Tue, 22 Oct 2019 13:39:29 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 4sm9093313ljv.87.2019.10.22.13.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:39:28 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:39:20 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     vinicius.gomes@intel.com, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: Re: [RESEND][PATCH net-next] net: sched: taprio: fix
 -Wmissing-prototypes warnings
Message-ID: <20191022133920.087f1779@cakuba.netronome.com>
In-Reply-To: <1571702262-25929-1-git-send-email-wang.yi59@zte.com.cn>
References: <1571702262-25929-1-git-send-email-wang.yi59@zte.com.cn>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 07:57:42 +0800, Yi Wang wrote:
> We get one warnings when build kernel W=3D1:
> net/sched/sch_taprio.c:1155:6: warning: no previous prototype for =E2=80=
=98taprio_offload_config_changed=E2=80=99 [-Wmissing-prototypes]
>=20
> Make the function static to fix this.
>=20
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Thank you!

I've added Fixes tag and applied this to the net tree, since the warning
is already present there.
