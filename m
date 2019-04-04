Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E678C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08ED92082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry6H0Kxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfDDTqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:46:51 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:35383 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfDDTqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:46:50 -0400
Received: by mail-wm1-f53.google.com with SMTP id y197so4815598wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Nlqz6zaxI2WrhBCFtpSz6WKJq4kfNbrdFbNtRtXQDg=;
        b=Ry6H0KxocvWFVc8UuGeqlm1+cpwKMXpxPoz6nGVnEJatY5GsmQml6Ud6xIPoSEshMh
         lykEIy/mgI69jYBSqDTKtSO1y4FxLCHkPRuCmq2WNCcCNr96iCg5u1jm5aexzgyZKvUj
         mnSx/fo0/BsWlRqLmCgssiuVcHDJhSsz83qR44WviUuGPs04yvmuXL7HQ+7gfSGLk8oG
         qh6jOU8udk1yEUJMHCfgoatZvvIRx/SjEDGLh9oSsvOsaXvZBb3z1MeL4vI897Qc+oQG
         9r1hJ3euo6HpKtxN3ewTnceZjRIsw7zixtOvMRy9Jxrl23fvJGueKLUBSJDWt3r96wbz
         6M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Nlqz6zaxI2WrhBCFtpSz6WKJq4kfNbrdFbNtRtXQDg=;
        b=DqrbQ4fV3xP9Ki3ACK3XXP/DGn0l/gObF6Ac7FmKkjpiqFPZnCYGf4p7NCJ9T9thb4
         KyvwpKAD9f4Ia7bhaTAgvrSZ+0f6iPVEBM21sue40lvWHpH1rQaOTlZcb4hifxQmhcmT
         x+VwnsBif0IjqqXbnRyqq947b5OhYLSBX+Q6ZMra7zl2IfeKvjpS01dB6Gvt6wz5WuD3
         LlftpqsR2Wg2ajcCSCF2UOQcHPRqUIh4YqFVElBDKDhEACXrzpZF4sIGdmCFvBCzw7PF
         FSswMl/51VQX3geffPQIGN2uEnrfZcxVibHQV3G7/wL9aMCF/0ciwn2/ld5IEB6KmUff
         +VjQ==
X-Gm-Message-State: APjAAAUnkXsM9G3x3BLWcb6CIomFw7esLOrdgNmRXV3r8wjJE3lV58iS
        vt4tMf0gi7rOSXT9e8gkbZh5nv1793q4JQ==
X-Google-Smtp-Source: APXvYqx8i4HUN5CF4H9oTFf11VnhKrNTeaLx2IuM0YJQcvMshQwxm8VrV94QOBaolMmS6fycI9HMCQ==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr5523364wme.62.1554407208963;
        Thu, 04 Apr 2019 12:46:48 -0700 (PDT)
Received: from localhost.localdomain ([185.219.177.201])
        by smtp.gmail.com with ESMTPSA id f11sm23047400wrm.30.2019.04.04.12.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 12:46:48 -0700 (PDT)
From:   Okash Khawaja <okash.khawaja@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, Ben Hutchings <ben@decadent.org.uk>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        John Covici <covici@ccs.covici.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        devel@driverdev.osuosl.org, speakup@linux-speakup.org
Subject: [PATCH 0/2] staging: speakup: factor out selection code
Date:   Thu,  4 Apr 2019 20:45:28 +0100
Message-Id: <20190404194530.1170-1-okash.khawaja@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Speakup's selection functionality parallels that of
drivers/tty/vt/selection.c. This patch set replaces speakup's
implementation with calls to vt's selection code. This is one of the
remaining items in our TODO file and it's needed for moving speakup out
of staging.

Please note that in speakup selection is set inside interrupt context of
keyboard handler. Set selection code in vt happens in process context
and hence expects ability to sleep. To address this, there were two
options: farm out speakup's set selection into a work_struct thread, or
create atomic version of vt's set_selection. These patches implement
the former option.

Here's a summary:

Patch 1 re-arranges code in vt and exports some functions.
Patch 2 replaces speakup's selection code with calls to vt's functions
exported in patch 1.

Thanks,
Okash

