Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2991FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D2C20644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NO0/kwiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfITODe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:03:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33262 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfITODd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:03:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id x134so7455168qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=L7RuMAWb39SKa2KSDUpnhn/WYPqF8ZgNcdG8xyngyco=;
        b=NO0/kwiMlrquEUDojFfFwuhDiadYS5FpTfczDYCVtDyMD1FTwhaYY0o8st6uKTL052
         HE6nTnD9ZpDARbznFQW24Y2I50WbpveoF6DKZrgLMOwwrq2/Cp67T9txTNLVZ06RdkaV
         2aQit8GiFY0Xs73/kVBtqrN+dm7jVYs9tbMCDVZRTPzFpcYINjnUwM2EJGAB4dWNJha/
         7iWiX3NYR1pmwzFWydQC0etnDIlcSG+xsT6aV/K8nXp1Pl+sB5eRa6S0fnf7IGUMpqEw
         ADbxwZftvl+wcrJLa8zPMBJz4zI7OWLeZd4EIpPeT32AyGyhP4ugiEoTRcTTTnlMTLcT
         Y3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=L7RuMAWb39SKa2KSDUpnhn/WYPqF8ZgNcdG8xyngyco=;
        b=bwuRR2wte46hjYYw8PpujhKcOHw19f9xY/w/cIltctS/ohNkDbBMhlE0Ek/hHui+dq
         j9HMfEvBfgUDmzJdlm9LrS+a1Y1rX9Fnu12hvrhQa8P1VVNXiz5nRKR5kyDecSrEtatP
         BupwugJ8fGl6ny72gf9AdgongOFVoA1MJkljQEm7HZhRARa8/eHAdI7AL5hXjKFoQ5Ku
         goYPhj01MJlXA1X1aUm3OEptLJO2zLijfs1LgW6GwNVVQUAstqdlmtJOo/14ZbGiJi3U
         FxtfatlDe3eWld81+Y2UbJm9B8X0lnNy+Z0ZJoDgVedjd7LEhJxmf4Z940xFhrelsv6O
         ciQQ==
X-Gm-Message-State: APjAAAWjeF3Kf8rBpzUcOhuQlYMOS18n5vNHKnh5/BHWVQCjMspbFnG4
        SgWBeH1wWAGxKDkogZEbPdJoBpLTcHs=
X-Google-Smtp-Source: APXvYqz7xf+uhcLiwlHa/946hKTmZusRDQE6yoga9DQM2zUtnTJu0OL63p57KFHGatmK4OdryW5beg==
X-Received: by 2002:a37:bd43:: with SMTP id n64mr3931409qkf.130.1568988211117;
        Fri, 20 Sep 2019 07:03:31 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w131sm1164185qka.85.2019.09.20.07.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 07:03:30 -0700 (PDT)
Message-ID: <1568988209.5576.199.camel@lca.pw>
Subject: "Pick the right alignment default when creating dax devices" failed
 to build on powerpc
From:   Qian Cai <cai@lca.pw>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Sep 2019 10:03:29 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "libnvdimm/dax: Pick the right alignment default when
creating dax devices" causes powerpc failed to build with this config. Reverted
it fixed the issue.

ERROR: "hash__has_transparent_hugepage" [drivers/nvdimm/libnvdimm.ko] undefined!
ERROR: "radix__has_transparent_hugepage" [drivers/nvdimm/libnvdimm.ko]
undefined!
make[1]: *** [scripts/Makefile.modpost:93: __modpost] Error 1
make: *** [Makefile:1305: modules] Error 2

[1] https://patchwork.kernel.org/patch/11133445/
[2] https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
