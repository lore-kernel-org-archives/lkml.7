Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05B8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D44207FA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnnQgc2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbfK2Vfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:35:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52655 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387425AbfK2Vfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575063331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVwR89GpLJvgOqcOYsvRfM8XUB2WN/29zxkwIRsm8Ds=;
        b=SnnQgc2JUer5Z5iiteeGCelFH2r4DK9LlOigRvi6Il0Q6kPA+KLaffNadEqwuxSJKPIUWe
        WBLtcbnB18iieNOtPjjADwbpnCgLar/QbTEOj0ja9w9IGjFiI2dkIWPqwwKFb3HGSgSomg
        wKJ4y30ziMfZ4YHL7BlGPsOEN+Ik+Bo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-H3nxuc-MOUSMcxuTgtkD0Q-1; Fri, 29 Nov 2019 16:35:28 -0500
Received: by mail-qv1-f70.google.com with SMTP id bt18so2773196qvb.19
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/ru2uLWH98VwOEpQ4g8Db5rqCjk9Lo4bBQ00K16x0M=;
        b=qaurJiDP4UWZAt0/E7/Z0czzoQeSXqOOVOgvHpabNtQ9gzdBuG8ymAENmQgFzMo1JA
         YwYp5MxzjAQ0/3NLprzWVJP0Fq1FfXtEa6DKhgHEb4Py9BgGwcaYo8pKpR2fR/q9Me8i
         wRuZOXbOSvidqJMd9uNaIQI0QbQrIc0wsApZhi3ulEiMuISnvFm7lL9XFR3HI1SEaMuT
         +qDWLzcVnmOJa5jAwdt1VoxGh/1Gv0lMpwPqScyfFo7IJU8UeqSpQ7ypF+zGHXSLj4Rj
         xfv5SCF5XNq11OpzIlKVr/3H5bsuFODPsrQuiqxaBBBekFo13/4NDF2YE4amHIrovduT
         ZVtA==
X-Gm-Message-State: APjAAAUSPhs+bQxp0A+ookCiy6cdLJBw0q90SYm6S83/7Ft8YyMDzIkY
        wA+LcllIJAF6HMUqF3MESwMMwZf2KuxMQGUH9ERbw8mmP+Iu2B/poQ9/R/mREzZVVmfVSb+2wO8
        2/CPvgntBZJI3vWgFlg2/Khu7
X-Received: by 2002:ad4:55e8:: with SMTP id bu8mr15973912qvb.61.1575063326997;
        Fri, 29 Nov 2019 13:35:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyO0sB52jgNAeOKc4OLF6WGBaoE6fp1MHQy2+mrUu67bIMbdQuVzZkL3OSLnKOEKAm8ZgDobg==
X-Received: by 2002:ad4:55e8:: with SMTP id bu8mr15973883qvb.61.1575063326723;
        Fri, 29 Nov 2019 13:35:26 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id h186sm10679046qkf.64.2019.11.29.13.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:35:25 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 11/15] KVM: selftests: Introduce after_vcpu_run hook for dirty log test
Date:   Fri, 29 Nov 2019 16:35:01 -0500
Message-Id: <20191129213505.18472-12-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129213505.18472-1-peterx@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: H3nxuc-MOUSMcxuTgtkD0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a hook for the checks after vcpu_run() completes.  Preparation
for the dirty ring test because we'll need to take care of another
exit reason.

Since at it, drop the pages_count because after all we have a better
summary right now with statistics, and clean it up a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 39 ++++++++++++--------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/s=
elftests/kvm/dirty_log_test.c
index a8ae8c0042a8..3542311f56ff 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -168,6 +168,15 @@ static void clear_log_collect_dirty_pages(struct kvm_v=
m *vm, int slot,
 =09kvm_vm_clear_dirty_log(vm, slot, bitmap, 0, num_pages);
 }
=20
+static void default_after_vcpu_run(struct kvm_vm *vm)
+{
+=09struct kvm_run *run =3D vcpu_state(vm, VCPU_ID);
+
+=09TEST_ASSERT(get_ucall(vm, VCPU_ID, NULL) =3D=3D UCALL_SYNC,
+=09=09    "Invalid guest sync status: exit_reason=3D%s\n",
+=09=09    exit_reason_str(run->exit_reason));
+}
+
 struct log_mode {
 =09const char *name;
 =09/* Hook when the vm creation is done (before vcpu creation) */
@@ -175,16 +184,20 @@ struct log_mode {
 =09/* Hook to collect the dirty pages into the bitmap provided */
 =09void (*collect_dirty_pages) (struct kvm_vm *vm, int slot,
 =09=09=09=09     void *bitmap, uint32_t num_pages);
+=09/* Hook to call when after each vcpu run */
+=09void (*after_vcpu_run)(struct kvm_vm *vm);
 } log_modes[LOG_MODE_NUM] =3D {
 =09{
 =09=09.name =3D "dirty-log",
 =09=09.create_vm_done =3D NULL,
 =09=09.collect_dirty_pages =3D dirty_log_collect_dirty_pages,
+=09=09.after_vcpu_run =3D default_after_vcpu_run,
 =09},
 =09{
 =09=09.name =3D "clear-log",
 =09=09.create_vm_done =3D clear_log_create_vm_done,
 =09=09.collect_dirty_pages =3D clear_log_collect_dirty_pages,
+=09=09.after_vcpu_run =3D default_after_vcpu_run,
 =09},
 };
=20
@@ -224,6 +237,14 @@ static void log_mode_collect_dirty_pages(struct kvm_vm=
 *vm, int slot,
 =09mode->collect_dirty_pages(vm, slot, bitmap, num_pages);
 }
=20
+static void log_mode_after_vcpu_run(struct kvm_vm *vm)
+{
+=09struct log_mode *mode =3D &log_modes[host_log_mode];
+
+=09if (mode->after_vcpu_run)
+=09=09mode->after_vcpu_run(vm);
+}
+
 static void generate_random_array(uint64_t *guest_array, uint64_t size)
 {
 =09uint64_t i;
@@ -237,31 +258,17 @@ static void *vcpu_worker(void *data)
 =09int ret;
 =09struct kvm_vm *vm =3D data;
 =09uint64_t *guest_array;
-=09uint64_t pages_count =3D 0;
-=09struct kvm_run *run;
-
-=09run =3D vcpu_state(vm, VCPU_ID);
=20
 =09guest_array =3D addr_gva2hva(vm, (vm_vaddr_t)random_array);
-=09generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
=20
 =09while (!READ_ONCE(host_quit)) {
+=09=09generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
 =09=09/* Let the guest dirty the random pages */
 =09=09ret =3D _vcpu_run(vm, VCPU_ID);
 =09=09TEST_ASSERT(ret =3D=3D 0, "vcpu_run failed: %d\n", ret);
-=09=09if (get_ucall(vm, VCPU_ID, NULL) =3D=3D UCALL_SYNC) {
-=09=09=09pages_count +=3D TEST_PAGES_PER_LOOP;
-=09=09=09generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
-=09=09} else {
-=09=09=09TEST_ASSERT(false,
-=09=09=09=09    "Invalid guest sync status: "
-=09=09=09=09    "exit_reason=3D%s\n",
-=09=09=09=09    exit_reason_str(run->exit_reason));
-=09=09}
+=09=09log_mode_after_vcpu_run(vm);
 =09}
=20
-=09DEBUG("Dirtied %"PRIu64" pages\n", pages_count);
-
 =09return NULL;
 }
=20
--=20
2.21.0

