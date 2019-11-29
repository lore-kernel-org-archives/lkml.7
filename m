Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33A0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF18206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ffufnld/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbfK2Vfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:35:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50598 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387427AbfK2Vfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575063332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8QU/MqZQ7iCrQiVB69BeiYZxD7DRU81Tku8GelhIUiI=;
        b=Ffufnld/AeEq7a0cSRlGw8PdJU9Oof6h2L/s/l/G5Uc9Fn7f01JxlOqk6WgX79MnCnlp+W
        f3DWR65SH+Yl0iUJknPUSo9FCmhjYL7v5H/ds8PISj6H4b04znLpHdxOl3G/qjogUe9UDP
        Z0vMTYcD2Sd9pCW/3OMOVGFRqqvA/DU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-tgemr83MOR64C5Hi2xLn2w-1; Fri, 29 Nov 2019 16:35:31 -0500
Received: by mail-qt1-f199.google.com with SMTP id q17so3842066qtc.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ph8QPMVUt3TogI2QUxz0d6tIzYuPtW9qXzgfM49LbX4=;
        b=fiKg6LIi1Pj8Y+tWN9ehrOvhgNOGp9SxDTqmpKx+QovmiDW6HC5NZ0rbotEsSSWnmS
         acElyGYYAC0G1SwPuD+pxCnUM9lxxEr5oDIHKk8efks1MjIYsNtkWDj274tc62/0zOGT
         q9cDMb8LmiL38ZVl9hwI+n3rwqg9n8Of9uc54wN5rg1J4mIkZYk+K4x6klFBgvm2tyQx
         pE17sM7Ej6ekyzTyU+lOgi+g/9gG1MgM2qpxFnbhkz/UJ/aIjMMk6iKXLzMf8wgSoTqZ
         JoQsabVVwCeaKvtQuTrKmEASlWHPf5usVeK2Jpr1SK7vdC3EWwdylrNyQH28t8Kpz49h
         O/Nw==
X-Gm-Message-State: APjAAAVbeFMbIpoZ7KM+WIEoaxbSMyK68ZrLsuizLhvhlfZp5vroTXG5
        iGecy1SCVUCgPhhB+DYp+xepO84xj8HN4BHVPUoNUrP1E2UGJrP4Qh5nfnAtIIObCU8eiq7aAn8
        N+LCpu9igMUE3P8FboovQcqcm
X-Received: by 2002:a05:6214:82:: with SMTP id n2mr19784790qvr.199.1575063330859;
        Fri, 29 Nov 2019 13:35:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+kM+aluFDpDmrKxZEi1V2tHOv0XcDObShdoHe1wBVP230mj/s8I3XMHXPIKR24luMQ/sn5A==
X-Received: by 2002:a05:6214:82:: with SMTP id n2mr19784772qvr.199.1575063330639;
        Fri, 29 Nov 2019 13:35:30 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id h186sm10679046qkf.64.2019.11.29.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:35:30 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 14/15] KVM: selftests: Add "-c" parameter to dirty log test
Date:   Fri, 29 Nov 2019 16:35:04 -0500
Message-Id: <20191129213505.18472-15-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129213505.18472-1-peterx@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: tgemr83MOR64C5Hi2xLn2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used to override the existing dirty ring size/count.  If
with a bigger ring count, we test async of dirty ring.  If with a
smaller ring count, we test ring full code path.

It has no use for non-dirty-ring tests.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/s=
elftests/kvm/dirty_log_test.c
index 4799db91e919..c9db136a1f12 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -157,6 +157,7 @@ enum log_mode_t {
 /* Mode of logging.  Default is LOG_MODE_DIRTY_LOG */
 static enum log_mode_t host_log_mode;
 pthread_t vcpu_thread;
+static uint32_t test_dirty_ring_count =3D TEST_DIRTY_RING_COUNT;
=20
 /* Only way to pass this to the signal handler */
 struct kvm_vm *current_vm;
@@ -216,7 +217,7 @@ static void dirty_ring_create_vm_done(struct kvm_vm *vm=
)
 =09 * Switch to dirty ring mode after VM creation but before any
 =09 * of the vcpu creation.
 =09 */
-=09vm_enable_dirty_ring(vm, TEST_DIRTY_RING_COUNT *
+=09vm_enable_dirty_ring(vm, test_dirty_ring_count *
 =09=09=09     sizeof(struct kvm_dirty_gfn));
 }
=20
@@ -658,6 +659,9 @@ static void help(char *name)
 =09printf("usage: %s [-h] [-i iterations] [-I interval] "
 =09       "[-p offset] [-m mode]\n", name);
 =09puts("");
+=09printf(" -c: specify dirty ring size, in number of entries\n");
+=09printf("     (only useful for dirty-ring test; default: %"PRIu32")\n",
+=09       TEST_DIRTY_RING_COUNT);
 =09printf(" -i: specify iteration counts (default: %"PRIu64")\n",
 =09       TEST_HOST_LOOP_N);
 =09printf(" -I: specify interval in ms (default: %"PRIu64" ms)\n",
@@ -713,8 +717,11 @@ int main(int argc, char *argv[])
 =09vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
=20
-=09while ((opt =3D getopt(argc, argv, "hi:I:p:m:M:")) !=3D -1) {
+=09while ((opt =3D getopt(argc, argv, "c:hi:I:p:m:M:")) !=3D -1) {
 =09=09switch (opt) {
+=09=09case 'c':
+=09=09=09test_dirty_ring_count =3D strtol(optarg, NULL, 10);
+=09=09=09break;
 =09=09case 'i':
 =09=09=09iterations =3D strtol(optarg, NULL, 10);
 =09=09=09break;
--=20
2.21.0

