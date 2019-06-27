Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B719C004E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBD820665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ejPABeh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfF0UYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:24:43 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:53323 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF0UYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:24:39 -0400
Received: by mail-vs1-f73.google.com with SMTP id b23so1152376vsl.20
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x+zWoYb3OEB93ZrYqw2awl77D28JgmnclJmBViN44H4=;
        b=ejPABeh3HrJ5MjI0uvNPsR3WpKL0QNP2sf8hcWcK8q1KuOiJ1bnwbsj8cYVD+jZEWR
         nDgVwuXMCiRc1jg5oCWXufqQcrtrj/1u2ZEnFXLbOtR7I22u5EoLvGmt/p2fAZmqp2rB
         jnpTkM+MDpcTUM5TebWW8yfpcl8lIxvN6YRsCsg++gK1017NVXPjXQvnjspLWqv+NC5H
         YGvgfwaIu8/NsQ9EdSa51EDM3WRhw9DBWkS6bMLRhKeaC1+Yt2s4NMEXkz820GwEtDFh
         DsiEbi2xxyxu5Wsqsm8nXo0ZZIMkBb++iFM/Xp0A1BCFPQVo3rJwfdM2BI+IXtpXjOOR
         cR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x+zWoYb3OEB93ZrYqw2awl77D28JgmnclJmBViN44H4=;
        b=ujfKwyjzsF3+I8jV4k5y0LaeGq9O2OgFn2hJq29d0iyxKFUSV4JUkFSncfzQTeColS
         mDBL43e/my7c5F/8b1MXq/gQEK9ZgSqPB2nd5CqaJthi1rgoydKWu6T5rKY5wtf2M+f/
         NVx+kMIv46gU/+f+76QEhHC3RK3zu1MKRWmEIMMHvan6AAGiiSNOHizZ+pH6RAcDNRR5
         EOa3X3irmbiuRl3hypz/HY8xyYyQwbyhwDtnHO+xZ5DLuwIT5w9DkTpF+8Hx+5u+pp2z
         NxxHtU7yViTfZXnMpBAGhgsZJW7p2rKzjtXSFQFLZoGaNHusUnr04cRvaA+Kpr+YnFpf
         kC3g==
X-Gm-Message-State: APjAAAVw2CY3LURr7KMFOgV6LMbut+LQ66OP2oOJgB7cGf0wJ6v/pEG6
        FHC50gZoa5yPDDnPDvQSP8Eq2rHkXwAd
X-Google-Smtp-Source: APXvYqyuQgvuJ1yFYSQDnjt0mvywRc4BGtTMrY5kgm7wbtoBF/+fzc2RSJE/ie8lWBaVnk//3C9fe16w4LI7
X-Received: by 2002:a67:7a90:: with SMTP id v138mr4015150vsc.200.1561667078376;
 Thu, 27 Jun 2019 13:24:38 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:24:13 -0700
In-Reply-To: <20190627202417.33370-1-brianvv@google.com>
Message-Id: <20190627202417.33370-3-brianvv@google.com>
Mime-Version: 1.0
References: <20190627202417.33370-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH bpf-next v2 2/6] bpf: add BPF_MAP_DUMP command to access
 more than one entry per call
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a new command to retrieve a variable number of entries
from a bpf map wrapping the existing bpf methods:
map_get_next_key and map_lookup_elem

Note that map_dump doesn't guarantee that reading the entire table is
consistent since this function is always racing with kernel and user code
but the same behaviour is found when the entire table is walked using
the current interfaces: map_get_next_key + map_lookup_elem.
It is also important to note that when a locked map is provided it is
consistent only for 1 entry at the time, meaning that the buf returned
might or might not be consistent.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 include/uapi/linux/bpf.h |   9 ++++
 kernel/bpf/syscall.c     | 108 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b077507efa3f3..1d753958874df 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -106,6 +106,7 @@ enum bpf_cmd {
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
+	BPF_MAP_DUMP,
 };
 
 enum bpf_map_type {
@@ -385,6 +386,14 @@ union bpf_attr {
 		__u64		flags;
 	};
 
+	struct { /* struct used by BPF_MAP_DUMP command */
+		__u32		map_fd;
+		__aligned_u64	prev_key;
+		__aligned_u64	buf;
+		__aligned_u64	buf_len; /* input/output: len of buf */
+		__u64		flags;
+	} dump;
+
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a1823a50f9be0..7653346b5cfd1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1097,6 +1097,111 @@ static int map_get_next_key(union bpf_attr *attr)
 	return err;
 }
 
+/* last field in 'union bpf_attr' used by this command */
+#define BPF_MAP_DUMP_LAST_FIELD dump.buf_len
+
+static int map_dump(union bpf_attr *attr)
+{
+	void __user *ukey = u64_to_user_ptr(attr->dump.prev_key);
+	void __user *ubuf = u64_to_user_ptr(attr->dump.buf);
+	u32 __user *ubuf_len = u64_to_user_ptr(attr->dump.buf_len);
+	int ufd = attr->dump.map_fd;
+	struct bpf_map *map;
+	void *buf, *prev_key, *key, *value;
+	u32 value_size, elem_size, buf_len, cp_len;
+	struct fd f;
+	int err;
+
+	if (CHECK_ATTR(BPF_MAP_DUMP))
+		return -EINVAL;
+
+	attr->flags = 0;
+	if (attr->dump.flags & ~BPF_F_LOCK)
+		return -EINVAL;
+
+	f = fdget(ufd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
+	if ((attr->dump.flags & BPF_F_LOCK) &&
+	    !map_value_has_spin_lock(map)) {
+		err = -EINVAL;
+		goto err_put;
+	}
+
+	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
+	    map->map_type == BPF_MAP_TYPE_STACK) {
+		err = -ENOTSUPP;
+		goto err_put;
+	}
+
+	value_size = bpf_map_value_size(map);
+
+	err = get_user(buf_len, ubuf_len);
+	if (err)
+		goto err_put;
+
+	elem_size = map->key_size + value_size;
+	if (buf_len < elem_size) {
+		err = -EINVAL;
+		goto err_put;
+	}
+
+	if (ukey) {
+		prev_key = __bpf_copy_key(ukey, map->key_size);
+		if (IS_ERR(prev_key)) {
+			err = PTR_ERR(prev_key);
+			goto err_put;
+		}
+	} else {
+		prev_key = NULL;
+	}
+
+	err = -ENOMEM;
+	buf = kmalloc(elem_size, GFP_USER | __GFP_NOWARN);
+	if (!buf)
+		goto err_put;
+
+	key = buf;
+	value = key + map->key_size;
+	for (cp_len = 0;  cp_len + elem_size <= buf_len ; cp_len += elem_size) {
+next:
+		if (signal_pending(current)) {
+			err = -EINTR;
+			break;
+		}
+
+		rcu_read_lock();
+		err = map->ops->map_get_next_key(map, prev_key, key);
+		rcu_read_unlock();
+
+		if (err)
+			break;
+
+		if (bpf_map_copy_value(map, key, value, attr->dump.flags))
+			goto next;
+
+		if (copy_to_user(ubuf + cp_len, buf, elem_size))
+			break;
+
+		prev_key = key;
+	}
+
+	if (cp_len)
+		err = 0;
+	if (copy_to_user(ubuf_len, &cp_len, sizeof(cp_len)))
+		err = -EFAULT;
+	kfree(buf);
+err_put:
+	fdput(f);
+	return err;
+}
+
 #define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD value
 
 static int map_lookup_and_delete_elem(union bpf_attr *attr)
@@ -2891,6 +2996,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_MAP_LOOKUP_AND_DELETE_ELEM:
 		err = map_lookup_and_delete_elem(&attr);
 		break;
+	case BPF_MAP_DUMP:
+		err = map_dump(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
-- 
2.22.0.410.gd8fdbe21b5-goog

