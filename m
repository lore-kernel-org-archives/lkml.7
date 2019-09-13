Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2164BC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA172206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="F1FuNFCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbfIMVLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:11:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50638 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730990AbfIMVLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:11:30 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8DL8pla028943
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:11:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ckiRBeicPGISv0gecyDnhwKZLNjOoRIvQ7vcF+njPfc=;
 b=F1FuNFCYHQsZ0MEtHKjaCgbnU+tFS20zFSSpm/3SdCOOhuO08pvP8p8pZOms2DYV1rXp
 Y9hNpwLV9snYv4c4NanJyGK1qZ0Z7ggFxYwQeMQKsbSsQ0TEVrcjaCEFYE2ByJrwaYOX
 82HY32ZPceaYviiEbXA4PF8t0byxtEYdcco= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uytd6nwvw-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:11:29 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 13 Sep 2019 14:11:26 -0700
Received: by devbig059.prn3.facebook.com (Postfix, from userid 4924)
        id 9E4731741979; Fri, 13 Sep 2019 14:11:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Lucian Adrian Grijincu <lucian@fb.com>
Smtp-Origin-Hostname: devbig059.prn3.facebook.com
To:     Lucian Adrian Grijincu <lucian@fb.com>, <linux-mm@kvack.org>,
        Souptick Joarder <jrdr.linux@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@fb.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn3c05
Subject: [PATCH v3] mm: memory: fix /proc/meminfo reporting for MLOCK_ONFAULT
Date:   Fri, 13 Sep 2019 14:11:19 -0700
Message-ID: <20190913211119.416168-1-lucian@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_10:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=2
 clxscore=1015 mlxscore=0 mlxlogscore=688 spamscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909130211
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pages are faulted in MLOCK_ONFAULT correctly updates
/proc/self/smaps, but doesn't update /proc/meminfo's Mlocked field.

- Before this /proc/meminfo fields didn't change as pages were faulted in:

= Start =
/proc/meminfo
Unevictable:       10128 kB
Mlocked:           10132 kB
= Creating testfile =

= after mlock2(MLOCK_ONFAULT) =
/proc/meminfo
Unevictable:       10128 kB
Mlocked:           10132 kB
/proc/self/smaps
7f8714000000-7f8754000000 rw-s 00000000 08:04 50857050   /root/testfile
Locked:                0 kB

= after reading half of the file =
/proc/meminfo
Unevictable:       10128 kB
Mlocked:           10132 kB
/proc/self/smaps
7f8714000000-7f8754000000 rw-s 00000000 08:04 50857050   /root/testfile
Locked:           524288 kB

= after reading the entire the file =
/proc/meminfo
Unevictable:       10128 kB
Mlocked:           10132 kB
/proc/self/smaps
7f8714000000-7f8754000000 rw-s 00000000 08:04 50857050   /root/testfile
Locked:          1048576 kB

= after munmap =
/proc/meminfo
Unevictable:       10128 kB
Mlocked:           10132 kB
/proc/self/smaps

- After: /proc/meminfo fields are properly updated as pages are touched:

= Start =
/proc/meminfo
Unevictable:          60 kB
Mlocked:              60 kB
= Creating testfile =

= after mlock2(MLOCK_ONFAULT) =
/proc/meminfo
Unevictable:          60 kB
Mlocked:              60 kB
/proc/self/smaps
7f2b9c600000-7f2bdc600000 rw-s 00000000 08:04 63045798   /root/testfile
Locked:                0 kB

= after reading half of the file =
/proc/meminfo
Unevictable:      524220 kB
Mlocked:          524220 kB
/proc/self/smaps
7f2b9c600000-7f2bdc600000 rw-s 00000000 08:04 63045798   /root/testfile
Locked:           524288 kB

= after reading the entire the file =
/proc/meminfo
Unevictable:     1048496 kB
Mlocked:         1048508 kB
/proc/self/smaps
7f2b9c600000-7f2bdc600000 rw-s 00000000 08:04 63045798   /root/testfile
Locked:          1048576 kB

= after munmap =
/proc/meminfo
Unevictable:         176 kB
Mlocked:              60 kB
/proc/self/smaps

Repro code.
---

int mlock2wrap(const void* addr, size_t len, int flags) {
  return syscall(SYS_mlock2, addr, len, flags);
}

void smaps() {
  char smapscmd[1000];
  snprintf(
      smapscmd,
      sizeof(smapscmd) - 1,
      "grep testfile -A 20 /proc/%d/smaps | grep -E '(testfile|Locked)'",
      getpid());
  printf("/proc/self/smaps\n");
  fflush(stdout);
  system(smapscmd);
}

void meminfo() {
  const char* meminfocmd = "grep -E '(Mlocked|Unevictable)' /proc/meminfo";
  printf("/proc/meminfo\n");
  fflush(stdout);
  system(meminfocmd);
}

  {                                                 \
    int rc = (call);                                \
    if (rc != 0) {                                  \
      printf("error %d %s\n", rc, strerror(errno)); \
      exit(1);                                      \
    }                                               \
  }
int main(int argc, char* argv[]) {
  printf("= Start =\n");
  meminfo();

  printf("= Creating testfile =\n");
  size_t size = 1 << 30; // 1 GiB
  int fd = open("testfile", O_CREAT | O_RDWR, 0666);
  {
    void* buf = malloc(size);
    write(fd, buf, size);
    free(buf);
  }
  int ret = 0;
  void* addr = NULL;
  addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

  if (argc > 1) {
    PCHECK(mlock2wrap(addr, size, MLOCK_ONFAULT));
    printf("= after mlock2(MLOCK_ONFAULT) =\n");
    meminfo();
    smaps();

    for (size_t i = 0; i < size / 2; i += 4096) {
      ret += ((char*)addr)[i];
    }
    printf("= after reading half of the file =\n");
    meminfo();
    smaps();

    for (size_t i = 0; i < size; i += 4096) {
      ret += ((char*)addr)[i];
    }
    printf("= after reading the entire the file =\n");
    meminfo();
    smaps();

  } else {
    PCHECK(mlock(addr, size));
    printf("= after mlock =\n");
    meminfo();
    smaps();
  }

  PCHECK(munmap(addr, size));
  printf("= after munmap =\n");
  meminfo();
  smaps();

  return ret;
}

---

Signed-off-by: Lucian Adrian Grijincu <lucian@fb.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index e0c232fe81d9..55da24f33bc4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3311,6 +3311,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
+		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(page))
+			mlock_vma_page(page);
 	}
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
-- 
2.17.1

